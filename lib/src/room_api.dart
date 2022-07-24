import 'dart:async';

import 'package:leto_schema/leto_schema.dart';

import 'room_controller.dart';
import 'user_api.dart';
import 'util.dart';

part 'room_api.g.dart';

@GraphQLClass()
class Room implements RoomEvent {
  final String roomId;
  final List<User> users;

  final DateTime? lastMessageDate;
  final DateTime lastUpdateDate;
  final DateTime createdDate;

  const Room({
    required this.roomId,
    required this.users,
    required this.lastMessageDate,
    required this.lastUpdateDate,
    required this.createdDate,
  });
}

@GraphQLClass()
class RoomCreated {
  final Room room;
  final String token;

  RoomCreated({
    required this.room,
    required this.token,
  });
}

@GraphQLClass()
class RoomMessage implements RoomEvent {
  final String content;
  final User user;
  final DateTime createdDate;
  final String? recipientUserId;

  const RoomMessage({
    required this.content,
    required this.user,
    required this.createdDate,
    required this.recipientUserId,
  });
}

@GraphQLUnion()
class RoomEvent {
  const factory RoomEvent.message({
    required String content,
    required User user,
    required DateTime createdDate,
    required String? recipientUserId,
  }) = RoomMessage;

  const factory RoomEvent.room({
    required String roomId,
    required List<User> users,
    required DateTime? lastMessageDate,
    required DateTime lastUpdateDate,
    required DateTime createdDate,
  }) = Room;
}

@ClassResolver()
class RoomEndpoints {
  RoomEndpoints(this.controller);

  final RoomsController controller;

  static final ref = RefWithDefault(
    (scope) => RoomEndpoints(RoomsController.ref.get(scope)),
    scoped: false,
  );

  RoomController _getRoomForUser(String roomId, User user) {
    final room = controller.rooms[roomId];
    if (room == null) {
      throw RoomError(
        RoomErrorCode.roomIdNotFound,
        'No room with id "$roomId"',
      );
    }
    if (!room.isUserInRoom(user.userId)) {
      // room.users.add(user);
      throw RoomError(
        RoomErrorCode.userNotInRoom,
        'User "${user.userId}" not in room "$roomId"',
      );
    }
    return room;
  }

  @Query()
  List<Room> getListRoom(Ctx ctx) {
    final user = getUser(ctx);
    return controller.rooms.values
        .where((e) => e.isUserInRoom(user.userId))
        .map((e) => e.room)
        .toList();
  }

  @Mutation()
  RoomCreated createRoom(Ctx ctx) {
    final user = getUser(ctx);

    final newRoom = controller.createRoom(user);
    return RoomCreated(
      token: newRoom.token,
      room: newRoom.room,
    );
  }

  @Mutation()
  RoomCreated? resetTokenRoom(Ctx ctx, String roomId) {
    final user = getUser(ctx);
    final room = _getRoomForUser(roomId, user);
    if (room.creator.userId != user.userId) {
      return null;
    }
    controller.resetToken(room);
    return RoomCreated(
      token: room.token,
      room: room.room,
    );
  }

  // @Mutation()
  // Room? enterRoom(Ctx ctx, String token) {
  //   final user = getUser(ctx);
  //   final room = controller.roomsByToken[token];
  //   if (room != null) {
  //     room.addUser(user);
  //     return room.room;
  //   } else {
  //     return null;
  //   }
  // }

  @Mutation()
  RoomMessage sendMessageRoom(
    Ctx ctx,
    String roomId,
    String content,
    String? recipientUserId,
  ) {
    final user = getUser(ctx);
    final room = _getRoomForUser(roomId, user);

    if (recipientUserId != null && !room.isUserInRoom(recipientUserId)) {
      throw RoomError(
        RoomErrorCode.recipientNotInRoom,
        'recipientUserId "$recipientUserId" not found',
      );
    }

    final message = RoomMessage(
      content: content,
      user: user,
      createdDate: DateTime.now(),
      recipientUserId: recipientUserId,
    );
    room.sendMessage(message);
    return message;
  }

  @Subscription()
  Stream<RoomEvent> eventsRoom(Ctx ctx, String token) {
    final user = getUser(ctx);
    // final room = _getRoomForUser(roomId, user);
    final room = controller.roomsByToken[token];
    if (room == null) {
      throw RoomError(
        RoomErrorCode.invalidTokenRoom,
        'No room for token "$token"',
      );
    }

    StreamSubscription? messagesSubs;
    StreamSubscription? changesSubs;

    final streamController = StreamController<RoomEvent>();
    streamController.onListen = () {
      messagesSubs = room.messagesController.stream
          .where((event) =>
              event.recipientUserId == null ||
              event.recipientUserId == user.userId)
          .listen(streamController.add);
      changesSubs = room.changesController.stream.listen(streamController.add);
      room.addUser(user, streamController);
    };
    streamController.onCancel = () async {
      await (messagesSubs?.cancel() ?? Future.value());
      await (changesSubs?.cancel() ?? Future.value());
      room.removeUser(user);
    };

    return streamController.stream;
  }

  // @Subscription()
  // Stream<Room> changesRoom(Ctx ctx, String roomId) {
  //   final user = getUser(ctx);
  //   final room = _getRoomForUser(roomId, user);

  //   return room.changesController.stream;
  // }
}

enum RoomErrorCode {
  roomIdNotFound,
  userNotInRoom,
  recipientNotInRoom,
  invalidTokenRoom,
}

class RoomError extends AppError {
  @override
  final RoomErrorCode code;
  @override
  final String message;

  RoomError(
    this.code,
    this.message, {
    StackTrace? stackTrace,
  }) : super(stackTrace: stackTrace);
}
