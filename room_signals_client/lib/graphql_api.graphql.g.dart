// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUser$Mutation$UserCreated$User
    _$CreateUser$Mutation$UserCreated$UserFromJson(Map<String, dynamic> json) =>
        CreateUser$Mutation$UserCreated$User()
          ..$$typename = json['__typename'] as String?
          ..userId = json['userId'] as String;

Map<String, dynamic> _$CreateUser$Mutation$UserCreated$UserToJson(
        CreateUser$Mutation$UserCreated$User instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'userId': instance.userId,
    };

CreateUser$Mutation$UserCreated _$CreateUser$Mutation$UserCreatedFromJson(
        Map<String, dynamic> json) =>
    CreateUser$Mutation$UserCreated()
      ..token = json['token'] as String
      ..user = CreateUser$Mutation$UserCreated$User.fromJson(
          json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$CreateUser$Mutation$UserCreatedToJson(
        CreateUser$Mutation$UserCreated instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user.toJson(),
    };

CreateUser$Mutation _$CreateUser$MutationFromJson(Map<String, dynamic> json) =>
    CreateUser$Mutation()
      ..createUser = CreateUser$Mutation$UserCreated.fromJson(
          json['createUser'] as Map<String, dynamic>);

Map<String, dynamic> _$CreateUser$MutationToJson(
        CreateUser$Mutation instance) =>
    <String, dynamic>{
      'createUser': instance.createUser.toJson(),
    };

GetUser$Query$User _$GetUser$Query$UserFromJson(Map<String, dynamic> json) =>
    GetUser$Query$User()
      ..$$typename = json['__typename'] as String?
      ..userId = json['userId'] as String;

Map<String, dynamic> _$GetUser$Query$UserToJson(GetUser$Query$User instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'userId': instance.userId,
    };

GetUser$Query _$GetUser$QueryFromJson(Map<String, dynamic> json) =>
    GetUser$Query()
      ..getUser =
          GetUser$Query$User.fromJson(json['getUser'] as Map<String, dynamic>);

Map<String, dynamic> _$GetUser$QueryToJson(GetUser$Query instance) =>
    <String, dynamic>{
      'getUser': instance.getUser.toJson(),
    };

GetListRoom$Query$Room _$GetListRoom$Query$RoomFromJson(
        Map<String, dynamic> json) =>
    GetListRoom$Query$Room()
      ..$$typename = json['__typename'] as String?
      ..roomId = json['roomId'] as String
      ..lastMessageDate = fromGraphQLDateNullableToDartDateTimeNullable(
          json['lastMessageDate'] as String?)
      ..lastUpdateDate =
          fromGraphQLDateToDartDateTime(json['lastUpdateDate'] as String)
      ..createdDate =
          fromGraphQLDateToDartDateTime(json['createdDate'] as String)
      ..users = (json['users'] as List<dynamic>)
          .map((e) => $RoomMixin$User.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$GetListRoom$Query$RoomToJson(
        GetListRoom$Query$Room instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'roomId': instance.roomId,
      'lastMessageDate': fromDartDateTimeNullableToGraphQLDateNullable(
          instance.lastMessageDate),
      'lastUpdateDate': fromDartDateTimeToGraphQLDate(instance.lastUpdateDate),
      'createdDate': fromDartDateTimeToGraphQLDate(instance.createdDate),
      'users': instance.users.map((e) => e.toJson()).toList(),
    };

GetListRoom$Query _$GetListRoom$QueryFromJson(Map<String, dynamic> json) =>
    GetListRoom$Query()
      ..getListRoom = (json['getListRoom'] as List<dynamic>)
          .map(
              (e) => GetListRoom$Query$Room.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$GetListRoom$QueryToJson(GetListRoom$Query instance) =>
    <String, dynamic>{
      'getListRoom': instance.getListRoom.map((e) => e.toJson()).toList(),
    };

$RoomMixin$User _$$RoomMixin$UserFromJson(Map<String, dynamic> json) =>
    $RoomMixin$User()
      ..$$typename = json['__typename'] as String?
      ..userId = json['userId'] as String;

Map<String, dynamic> _$$RoomMixin$UserToJson($RoomMixin$User instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'userId': instance.userId,
    };

CreateRoom$Mutation$RoomCreated$Room
    _$CreateRoom$Mutation$RoomCreated$RoomFromJson(Map<String, dynamic> json) =>
        CreateRoom$Mutation$RoomCreated$Room()
          ..$$typename = json['__typename'] as String?
          ..roomId = json['roomId'] as String
          ..lastMessageDate = fromGraphQLDateNullableToDartDateTimeNullable(
              json['lastMessageDate'] as String?)
          ..lastUpdateDate =
              fromGraphQLDateToDartDateTime(json['lastUpdateDate'] as String)
          ..createdDate =
              fromGraphQLDateToDartDateTime(json['createdDate'] as String)
          ..users = (json['users'] as List<dynamic>)
              .map((e) => $RoomMixin$User.fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$CreateRoom$Mutation$RoomCreated$RoomToJson(
        CreateRoom$Mutation$RoomCreated$Room instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'roomId': instance.roomId,
      'lastMessageDate': fromDartDateTimeNullableToGraphQLDateNullable(
          instance.lastMessageDate),
      'lastUpdateDate': fromDartDateTimeToGraphQLDate(instance.lastUpdateDate),
      'createdDate': fromDartDateTimeToGraphQLDate(instance.createdDate),
      'users': instance.users.map((e) => e.toJson()).toList(),
    };

CreateRoom$Mutation$RoomCreated _$CreateRoom$Mutation$RoomCreatedFromJson(
        Map<String, dynamic> json) =>
    CreateRoom$Mutation$RoomCreated()
      ..token = json['token'] as String
      ..room = CreateRoom$Mutation$RoomCreated$Room.fromJson(
          json['room'] as Map<String, dynamic>);

Map<String, dynamic> _$CreateRoom$Mutation$RoomCreatedToJson(
        CreateRoom$Mutation$RoomCreated instance) =>
    <String, dynamic>{
      'token': instance.token,
      'room': instance.room.toJson(),
    };

CreateRoom$Mutation _$CreateRoom$MutationFromJson(Map<String, dynamic> json) =>
    CreateRoom$Mutation()
      ..createRoom = CreateRoom$Mutation$RoomCreated.fromJson(
          json['createRoom'] as Map<String, dynamic>);

Map<String, dynamic> _$CreateRoom$MutationToJson(
        CreateRoom$Mutation instance) =>
    <String, dynamic>{
      'createRoom': instance.createRoom.toJson(),
    };

SendMessageRoom$Mutation$RoomMessage
    _$SendMessageRoom$Mutation$RoomMessageFromJson(Map<String, dynamic> json) =>
        SendMessageRoom$Mutation$RoomMessage()
          ..$$typename = json['__typename'] as String?
          ..content = json['content'] as String
          ..createdDate =
              fromGraphQLDateToDartDateTime(json['createdDate'] as String)
          ..recipientUserId = json['recipientUserId'] as String?
          ..user = $RoomMessageMixin$User
              .fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$SendMessageRoom$Mutation$RoomMessageToJson(
        SendMessageRoom$Mutation$RoomMessage instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'content': instance.content,
      'createdDate': fromDartDateTimeToGraphQLDate(instance.createdDate),
      'recipientUserId': instance.recipientUserId,
      'user': instance.user.toJson(),
    };

SendMessageRoom$Mutation _$SendMessageRoom$MutationFromJson(
        Map<String, dynamic> json) =>
    SendMessageRoom$Mutation()
      ..sendMessageRoom = SendMessageRoom$Mutation$RoomMessage.fromJson(
          json['sendMessageRoom'] as Map<String, dynamic>);

Map<String, dynamic> _$SendMessageRoom$MutationToJson(
        SendMessageRoom$Mutation instance) =>
    <String, dynamic>{
      'sendMessageRoom': instance.sendMessageRoom.toJson(),
    };

$RoomMessageMixin$User _$$RoomMessageMixin$UserFromJson(
        Map<String, dynamic> json) =>
    $RoomMessageMixin$User()
      ..$$typename = json['__typename'] as String?
      ..userId = json['userId'] as String;

Map<String, dynamic> _$$RoomMessageMixin$UserToJson(
        $RoomMessageMixin$User instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'userId': instance.userId,
    };

EventsRoom$Subscription$RoomEvent$Room
    _$EventsRoom$Subscription$RoomEvent$RoomFromJson(
            Map<String, dynamic> json) =>
        EventsRoom$Subscription$RoomEvent$Room()
          ..$$typename = json['__typename'] as String?
          ..roomId = json['roomId'] as String
          ..lastMessageDate = fromGraphQLDateNullableToDartDateTimeNullable(
              json['lastMessageDate'] as String?)
          ..lastUpdateDate =
              fromGraphQLDateToDartDateTime(json['lastUpdateDate'] as String)
          ..createdDate =
              fromGraphQLDateToDartDateTime(json['createdDate'] as String)
          ..users = (json['users'] as List<dynamic>)
              .map((e) => $RoomMixin$User.fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$EventsRoom$Subscription$RoomEvent$RoomToJson(
        EventsRoom$Subscription$RoomEvent$Room instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'roomId': instance.roomId,
      'lastMessageDate': fromDartDateTimeNullableToGraphQLDateNullable(
          instance.lastMessageDate),
      'lastUpdateDate': fromDartDateTimeToGraphQLDate(instance.lastUpdateDate),
      'createdDate': fromDartDateTimeToGraphQLDate(instance.createdDate),
      'users': instance.users.map((e) => e.toJson()).toList(),
    };

EventsRoom$Subscription$RoomEvent$RoomMessage
    _$EventsRoom$Subscription$RoomEvent$RoomMessageFromJson(
            Map<String, dynamic> json) =>
        EventsRoom$Subscription$RoomEvent$RoomMessage()
          ..$$typename = json['__typename'] as String?
          ..content = json['content'] as String
          ..createdDate =
              fromGraphQLDateToDartDateTime(json['createdDate'] as String)
          ..recipientUserId = json['recipientUserId'] as String?
          ..user = $RoomMessageMixin$User
              .fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$EventsRoom$Subscription$RoomEvent$RoomMessageToJson(
        EventsRoom$Subscription$RoomEvent$RoomMessage instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'content': instance.content,
      'createdDate': fromDartDateTimeToGraphQLDate(instance.createdDate),
      'recipientUserId': instance.recipientUserId,
      'user': instance.user.toJson(),
    };

EventsRoom$Subscription$RoomEvent _$EventsRoom$Subscription$RoomEventFromJson(
        Map<String, dynamic> json) =>
    EventsRoom$Subscription$RoomEvent()
      ..$$typename = json['__typename'] as String?;

Map<String, dynamic> _$EventsRoom$Subscription$RoomEventToJson(
        EventsRoom$Subscription$RoomEvent instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
    };

EventsRoom$Subscription _$EventsRoom$SubscriptionFromJson(
        Map<String, dynamic> json) =>
    EventsRoom$Subscription()
      ..eventsRoom = EventsRoom$Subscription$RoomEvent.fromJson(
          json['eventsRoom'] as Map<String, dynamic>);

Map<String, dynamic> _$EventsRoom$SubscriptionToJson(
        EventsRoom$Subscription instance) =>
    <String, dynamic>{
      'eventsRoom': instance.eventsRoom.toJson(),
    };

SendMessageRoomArguments _$SendMessageRoomArgumentsFromJson(
        Map<String, dynamic> json) =>
    SendMessageRoomArguments(
      roomId: json['roomId'] as String,
      content: json['content'] as String,
      recipientUserId: json['recipientUserId'] as String?,
    );

Map<String, dynamic> _$SendMessageRoomArgumentsToJson(
        SendMessageRoomArguments instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'content': instance.content,
      'recipientUserId': instance.recipientUserId,
    };

EventsRoomArguments _$EventsRoomArgumentsFromJson(Map<String, dynamic> json) =>
    EventsRoomArguments(
      token: json['token'] as String,
    );

Map<String, dynamic> _$EventsRoomArgumentsToJson(
        EventsRoomArguments instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
