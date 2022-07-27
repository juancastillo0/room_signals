import 'dart:async';
import 'dart:convert' show jsonEncode, jsonDecode;

import 'package:artemis/artemis.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:room_signals_client/graphql_api.graphql.dart';

export 'package:room_signals_client/graphql_api.graphql.dart';

mixin ClientPersistence {
  FutureOr<void> put(String key, String value);
  FutureOr<String?> get(String key);
  FutureOr<bool> delete(String key);
}

class ClientPersistencePrefixed with ClientPersistence {
  final ClientPersistence inner;
  final String prefix;

  const ClientPersistencePrefixed({
    required this.inner,
    required this.prefix,
  });

  @override
  FutureOr<bool> delete(String key) => inner.delete('$prefix$key');

  @override
  FutureOr<String?> get(String key) => inner.get('$prefix$key');

  @override
  FutureOr<void> put(String key, String value) =>
      inner.put('$prefix$key', value);
}

class RoomSignalsClient {
  final String wsUrl;
  final ArtemisClient client;
  final WebSocketLink _link;
  final CreateUser$Mutation$UserCreated userCreated;
  final ClientPersistence? persistence;

  static const TOKEN_PERSISTENCE = 'room-signals-auth';
  static const ROOM_TOKENS_PERSISTENCE = 'room-signals-tokens';

  RoomSignalsClient._(
    this.wsUrl,
    this.client,
    this._link,
    this.userCreated,
    this.persistence,
  );

  static Future<RoomSignalsClient> create(
    String url, {
    Duration reconnectInterval = const Duration(seconds: 10),
    ClientPersistence? persistence,
  }) async {
    final wsUrl = url.startsWith('http') ? url.replaceFirst('http', 'ws') : url;

    String? token;
    if (persistence != null) {
      token = await persistence.get(TOKEN_PERSISTENCE);
    }

    WebSocketLink link = WebSocketLink(
      wsUrl,
      autoReconnect: true,
      reconnectInterval: reconnectInterval,
      initialPayload: token != null ? {TOKEN_PERSISTENCE: token} : null,
    );
    ArtemisClient client = ArtemisClient.fromLink(link);
    final response = await client.execute(CreateUserMutation(
      variables: CreateUserArguments(name: null),
    ));

    final createUser = response.data?.createUser;
    if (token == null || createUser == null) {
      client.dispose();
      await link.dispose();

      if (createUser == null) {
        if (persistence != null) {
          await persistence.delete(TOKEN_PERSISTENCE);
        }
        throw Exception(response.errors!);
      }

      link = WebSocketLink(
        wsUrl,
        autoReconnect: true,
        initialPayload: {TOKEN_PERSISTENCE: createUser.token},
        reconnectInterval: reconnectInterval,
      );
      client = ArtemisClient.fromLink(link);
    }

    if (persistence != null) {
      await persistence.put(TOKEN_PERSISTENCE, createUser.token);
    }

    final roomClient = RoomSignalsClient._(
      wsUrl,
      client,
      link,
      createUser,
      persistence,
    );
    if (persistence != null) {
      final tokens = await persistence.get(ROOM_TOKENS_PERSISTENCE);
      if (tokens != null) {
        try {
          final tokensList = (jsonDecode(tokens) as List).cast<String>();
          await Future.wait(tokensList.map(roomClient.subscribeToRoom));
        } catch (_) {}
      }
    }
    return roomClient;
  }

  Future<void> dispose() async {
    await _messageController.close();
    await _roomChangeController.close();
    client.dispose();
    await _link.dispose();
  }

  final _roomChangeController = StreamController<Room>.broadcast();
  final _messageController = StreamController<$RoomMessageMixin>.broadcast();
  Stream<Room> get roomChangeStream => _roomChangeController.stream;
  Stream<$RoomMessageMixin> get messageStream => _messageController.stream;

  final Map<String, Room> rooms = {};

  Future<GraphQLResponse<CreateRoom$Mutation>> createRoom() {
    return client.execute(CreateRoomMutation());
  }

  Future<GraphQLResponse<SendMessageRoom$Mutation>> sendMessage(
    SendMessageRoomArguments args,
  ) {
    if (!rooms.containsKey(args.roomId)) {
      throw Exception(
        'sendMessage should be called only for subscribed rooms.',
      );
    }
    return client.execute(SendMessageRoomMutation(variables: args));
  }

  Future<void> _syncPersistence() async {
    if (persistence != null) {
      final List<String> tokens =
          rooms.values.map((value) => value.token).toList();

      await persistence!.put(
        ROOM_TOKENS_PERSISTENCE,
        jsonEncode(tokens),
      );
    }
  }

  void _removeRoom(String roomId) {
    final room = rooms.remove(roomId);
    if (room != null) {
      room._isSubscribed = false;
      room.cancelSubscription();
      _roomChangeController.add(room);
      _syncPersistence();
    }
  }

  Future<Room> subscribeToRoom(String token) {
    final comp = Completer<Room>();
    late final StreamSubscription subs;
    String? roomId;

    void complete(Object? error, StackTrace? stackTrace) {
      if (comp.isCompleted) return;

      if (error != null) {
        if (roomId != null) {
          _removeRoom(roomId!);
        }
        comp.completeError(error, stackTrace);
      } else if (rooms.containsKey(roomId)) {
        comp.complete(rooms[roomId]);
        _syncPersistence();
      }
    }

    subs = client
        .stream(EventsRoomSubscription(
          variables: EventsRoomArguments(token: token),
        ))
        .listen(
          (event) {
            final data = event.data?.eventsRoom;
            if (data is EventsRoom$Subscription$RoomEvent$Room) {
              roomId ??= data.roomId;
              final room = rooms.update(
                data.roomId,
                (value) => value..data = data,
                ifAbsent: () => Room(
                  data: data,
                  cancelSubscription: () async {
                    await subs.cancel();
                    _removeRoom(data.roomId);
                  },
                  token: token,
                ),
              );
              _roomChangeController.add(room);
            } else if (data is EventsRoom$Subscription$RoomEvent$RoomMessage) {
              _messageController.add(data);
            }

            complete(event.errors, null);
          },
          cancelOnError: true,
          onError: complete,
          onDone: () {
            if (roomId != null) {
              _removeRoom(roomId!);
            }
          },
        );

    return comp.future;
  }
}

class Room {
  final String token;
  final Future<void> Function() cancelSubscription;
  $RoomMixin data;
  bool _isSubscribed = true;
  bool get isSubscribed => _isSubscribed;

  Room({
    required this.token,
    required this.data,
    required this.cancelSubscription,
  });
}

// class HttpClientWithHeaders extends http.BaseClient {
//   HttpClientWithHeaders(
//     this.getHeaders, {
//     http.Client? client,
//   }) : _client = client ?? http.Client();

//   final Future<Map<String, String>> Function() getHeaders;

//   final http.Client _client;

//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) async {
//     final customHeaders = await getHeaders();
//     request.headers.addAll(customHeaders);
//     return _client.send(request);
//   }
// }

// RoomSignalsClient(
//   this.url, {
//   http.Client? httpClient,
// }) : client = ArtemisClient.fromLink(
//         WebSocketLink(
//           url.startsWith(RegExp('http[s]://'))
//               ? url.replaceFirst(RegExp('http[s]://'), 'ws://')
//               : url,
//           autoReconnect: true,
//           initialPayload: {TOKEN_PERSISTENCE: ''},
//         ),
//       )
// client = ArtemisClient(
//         url,
//         httpClient: httpClient,
//       )
// ;
