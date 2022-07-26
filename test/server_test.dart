import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';
import 'package:room_signals/src/server_config.dart';
import 'package:room_signals_client/room_signals_client.dart';
import 'package:test/test.dart';

import '../bin/server.dart';

void main() {
  late String host;
  // late Process p;
  late HttpServer server;

  setUp(() async {
    // p = await Process.start(
    //   'dart',
    //   ['run', 'bin/server.dart'],
    //   environment: {'PORT': port},
    // );
    // // Wait for server to start and print to stdout.
    // await p.stdout.first;
    server = await startServer(
      config: ServerConfig(
        // use any available port
        port: 0,
        environment: AppEnvironment.development,
      ),
    );
    host = 'http://${server.address.address}:${server.port}';
  });

  tearDown(() => server.close());

  test('Root', () async {
    for (final path in [
      '/',
      '/graphql-schema',
      '/graphql-schema-interactive',
      '/graphql-altair',
      '/graphql-playground',
      '/graphql-graphiql',
    ]) {
      final response = await get(Uri.parse('$host$path'));
      expect(response.statusCode, 200);
      expect(
        response.headers['content-type'],
        path == '/graphql-schema' ? 'text/plain' : 'text/html',
      );
    }
  });

  test('Echo', () async {
    final response = await get(Uri.parse('$host/echo/hello'));
    expect(response.statusCode, 200);
    expect(response.body, 'hello\n');
  });

  test('404', () async {
    final response = await get(Uri.parse('$host/foobar'));
    expect(response.statusCode, 404);
  });

  test('Ping', () async {
    final response = await get(Uri.parse('$host/ping'));

    expect(response.statusCode, 200);
    expect(DateTime.parse(response.body), isNotNull);
  });

  test('graphql client', () async {
    final persistence = MapPersistence();
    final client = await RoomSignalsClient.create(
      '$host/graphql-subscription',
      persistence: persistence,
    );

    expect(persistence.values, {'room-signals-auth': client.userCreated.token});

    final client2 = await RoomSignalsClient.create(
      '$host/graphql-subscription',
    );

    final result = await client.createRoom();
    expect(result.errors ?? [], isEmpty);
    expect(result.errors ?? [], isEmpty);
    expect(client2.rooms, isEmpty);

    int eventId = 0;
    client.roomChangeStream.listen(expectAsync1(
      count: 3,
      (event) {
        eventId++;
        expect(event.data.users, hasLength(eventId == 2 ? 2 : 1));
      },
    ));

    final roomToken = result.data!.createRoom.token;
    final roomId = result.data!.createRoom.room.roomId;
    final room = await client.subscribeToRoom(roomToken);

    expect(room.token, roomToken);
    expect(room.data.roomId, roomId);
    expect(room.data.users, hasLength(1));
    expect(room.data.users.first.userId, client.userCreated.user.userId);
    expect(client.rooms, hasLength(1));

    final roomFrom2 = await client2.subscribeToRoom(roomToken);
    expect(roomFrom2.token, roomToken);
    expect(roomFrom2.data.roomId, roomId);
    expect(roomFrom2.data.users, hasLength(2));
    expect(roomFrom2.data.users.first.userId, client.userCreated.user.userId);
    expect(roomFrom2.data.users[1].userId, client2.userCreated.user.userId);

    int messageId = 0;
    client.messageStream.listen(expectAsync1(
      count: 2,
      (event) {
        messageId++;

        expect(
          event.content,
          messageId == 1 ? 'content from 2' : 'content from 1 to 1',
        );
        expect(
          event.recipientUserId,
          messageId == 1 ? null : client.userCreated.user.userId,
        );
      },
    ));
    client2.messageStream.listen(expectAsync1(
      count: 1,
      (event) {
        expect(
          event.content,
          'content from 2',
        );
        expect(
          event.recipientUserId,
          null,
        );
      },
    ));

    await client2.sendMessage(
      SendMessageRoomArguments(
        roomId: roomId,
        content: 'content from 2',
      ),
    );
    await client.sendMessage(
      SendMessageRoomArguments(
        roomId: roomId,
        content: 'content from 1 to 1',
        recipientUserId: client.userCreated.user.userId,
      ),
    );

    await roomFrom2.subscription.cancel();
  });
}

class MapPersistence implements ClientPersistence {
  final Map<String, String> values = {};

  @override
  FutureOr<bool> delete(String key) {
    return values.remove(key) != null;
  }

  @override
  FutureOr<String?> get(String key) {
    return values[key];
  }

  @override
  FutureOr<void> put(String key, String value) {
    values[key] = value;
  }
}
