import 'dart:async';

import 'package:leto/leto.dart';

import 'room_api.dart';
import 'user_api.dart';
import 'util.dart';

class RoomController {
  RoomController(
    this.creator, {
    DateTime? createdDate,
  }) : createdDate = createdDate ?? DateTime.now() {
    lastUpdateDate = this.createdDate;
  }

  final String id = randomId();
  String token = randomId();
  final User creator;

  DateTime? lastMessageDate;
  late DateTime lastUpdateDate;
  final DateTime createdDate;

  DateTime get lastDate => lastMessageDate == null
      ? lastUpdateDate
      : lastUpdateDate.isAfter(lastMessageDate!)
          ? lastUpdateDate
          : lastMessageDate!;

  final Map<String, UserRoom> users = {};
  final messagesController = StreamController<RoomMessage>.broadcast();
  final changesController = StreamController<Room>.broadcast();

  Room get room {
    return Room(
      roomId: id,
      users: users.values.map((u) => u.data).toList(),
      lastMessageDate: lastMessageDate,
      lastUpdateDate: lastUpdateDate,
      createdDate: createdDate,
    );
  }

  bool isUserInRoom(String userId) => users.containsKey(userId);

  void sendMessage(RoomMessage message) {
    lastMessageDate = message.createdDate;
    messagesController.add(message);
  }

  void addUser(User user, StreamController<RoomEvent> streamController) {
    if (!isUserInRoom(user.userId)) {
      lastUpdateDate = DateTime.now();
      users[user.userId] = UserRoom(
        data: user,
        streamController: streamController,
      );
      changesController.add(room);
    }
  }

  void removeUser(User user) {
    final value = users.remove(user.userId);
    if (value != null) {
      value.streamController.close();
      lastUpdateDate = DateTime.now();
      changesController.add(room);
    }
  }

  void dispose() {
    messagesController.close();
    changesController.close();
    for (final u in users.values) {
      u.streamController.close();
    }
  }
}

class UserRoom {
  final User data;
  final StreamController<RoomEvent> streamController;

  UserRoom({
    required this.data,
    required this.streamController,
  });
}

class RoomsController {
  RoomsController();

  void tryCleanUp() {
    const maxRooms = 10000;
    const roomsAfterCleanUp = 7000;
    if (rooms.length > maxRooms) {
      final sorted = rooms.values.toList()
        ..sort(
          (a, b) =>
              a.lastDate.millisecondsSinceEpoch -
              b.lastDate.millisecondsSinceEpoch,
        );
      for (final r in sorted.take(rooms.length - roomsAfterCleanUp)) {
        roomsByToken.remove(r.token);
        final room = rooms.remove(r.id)!;
        room.dispose();
      }
    }
  }

  static final ref = ScopedRef.global(
    (scope) => RoomsController(),
  );

  final Map<String, RoomController> rooms = {};
  final Map<String, RoomController> roomsByToken = {};

  void resetToken(RoomController room) {
    roomsByToken.remove(room.token);
    room.token = randomId();
    roomsByToken[room.token] = room;
  }

  RoomController createRoom(User user) {
    final newRoom = RoomController(user);
    rooms[newRoom.id] = newRoom;
    roomsByToken[newRoom.token] = newRoom;
    tryCleanUp();
    return newRoom;
  }
}
