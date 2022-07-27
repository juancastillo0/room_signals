import 'package:artemis/artemis.dart';
import 'package:room_signals_client/room_signals_client.dart';

void main() async {
  final client = await RoomSignalsClient.create(
    'ws://localhost:8080/graphql-subscription',
  );
  final GraphQLResponse<CreateRoom$Mutation> result = await client.createRoom();
  if (result.hasErrors) {
    throw result.errors!;
  }
  final CreateRoom$Mutation$RoomCreated createRoom = result.data!.createRoom;
  final Room room = await client.subscribeToRoom(createRoom.token);
  assert(room.data.roomId == createRoom.room.roomId);

  final List<$RoomMessageMixin?> messages = await Future.wait([
    client.messageStream.first.timeout(const Duration(seconds: 5)),
    client
        .sendMessage(SendMessageRoomArguments(
          content: 'message content',
          roomId: room.data.roomId,
        ))
        .then((value) => value.data?.sendMessageRoom),
  ]);
  assert(messages[0]?.messageId == messages[1]?.messageId);
}
