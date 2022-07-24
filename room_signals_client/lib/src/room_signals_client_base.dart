// TODO: Put public facing types in this file.

import 'dart:async';

import 'package:artemis/artemis.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';

import 'package:room_signals_client/graphql_api.graphql.dart';

export 'package:artemis/artemis.dart';
export 'package:room_signals_client/graphql_api.graphql.dart';

/// Checks if you are awesome. Spoiler: you are.
class Awesome {
  bool get isAwesome => true;
}

abstract class ClientPersistence {
  FutureOr<void> put(String key, String value);
  FutureOr<String?> get(String key);
  FutureOr<bool> delete(String key);
}

class RoomSignalsClient {
  final String wsUrl;
  final ArtemisClient client;
  final WebSocketLink _link;
  final CreateUser$Mutation$UserCreated userCreated;

  RoomSignalsClient._(
    this.wsUrl,
    this.client,
    this._link,
    this.userCreated,
  );

  static Future<RoomSignalsClient> create(
    String url, {
    Duration reconnectInterval = const Duration(seconds: 10),
    ClientPersistence? persistence,
  }) async {
    final httpsRegExp = RegExp('http[s]://');
    final wsUrl = url.startsWith(httpsRegExp)
        ? url.replaceFirst(httpsRegExp, 'ws://')
        : url;

    const TOKEN_PERSISTENCE = 'token';
    String? token;
    if (persistence != null) {
      token = await persistence.get(TOKEN_PERSISTENCE);
    }

    WebSocketLink link = WebSocketLink(
      wsUrl,
      autoReconnect: true,
      reconnectInterval: reconnectInterval,
      initialPayload: token != null ? {'token': token} : null,
    );
    ArtemisClient client = ArtemisClient.fromLink(link);
    final response = await client.execute(CreateUserMutation());

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
        initialPayload: {'token': createUser.token},
        reconnectInterval: reconnectInterval,
      );
      client = ArtemisClient.fromLink(link);
    }

    if (persistence != null) {
      await persistence.put(TOKEN_PERSISTENCE, createUser.token);
    }

    return RoomSignalsClient._(
      wsUrl,
      client,
      link,
      createUser,
    );
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

  void _removeRoom(String roomId) {
    final room = rooms.remove(roomId);
    if (room != null) {
      room._isSubscribed = false;
      room.subscription.cancel();
      _roomChangeController.add(room);
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
                  subscription: subs,
                  token: token,
                ),
              );
              _roomChangeController.add(room);
            } else if (data is EventsRoom$Subscription$RoomEvent$RoomMessage) {
              _messageController.add(data);
            } else {}

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
  final StreamSubscription subscription;
  $RoomMixin data;
  bool _isSubscribed = true;
  bool get isSubscribed => _isSubscribed;

  Room({
    required this.token,
    required this.data,
    required this.subscription,
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
//           initialPayload: {'token': ''},
//         ),
//       )
// client = ArtemisClient(
//         url,
//         httpClient: httpClient,
//       )
// ;