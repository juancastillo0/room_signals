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

  final Map<String, User> users = {};
  final messagesController = StreamController<RoomMessage>.broadcast();
  final changesController = StreamController<Room>.broadcast();

  Room get room {
    return Room(
      roomId: id,
      users: users.values.toList(),
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

  void addUser(User user) {
    if (!isUserInRoom(user.userId)) {
      lastUpdateDate = DateTime.now();
      users[user.userId] = user;
      changesController.add(room);
    }
  }

  void removeUser(User user) {
    if (isUserInRoom(user.userId)) {
      lastUpdateDate = DateTime.now();
      users.remove(user.userId);
      changesController.add(room);
    }
  }
}

class RoomsController {
  RoomsController();

  static final ref = RefWithDefault(
    (scope) => RoomsController(),
    scoped: false,
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
    return newRoom;
  }
}
