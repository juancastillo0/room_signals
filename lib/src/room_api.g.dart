// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_api.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<List<Room>, Object?, Object?> get getListRoomGraphQLField =>
    _getListRoomGraphQLField.value;
final _getListRoomGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<List<Room>, Object?, Object?>>(
        (setValue) =>
            setValue(roomGraphQLType.nonNull().list().nonNull().field<Object?>(
              'getListRoom',
              resolve: (obj, ctx) {
                final args = ctx.args;

                final _call = (RoomEndpoints r) => r.getListRoom(ctx);
                final FutureOr<RoomEndpoints>
                    _obj = // ignore: unnecessary_non_null_assertion
                    RoomEndpoints.ref.get(ctx)!;
                if (_obj is Future<RoomEndpoints>)
                  return _obj.then(_call);
                else
                  return _call(_obj);
              },
              description: 'Returns the list of currently subscribed rooms.',
            )));

GraphQLObjectField<RoomCreated, Object?, Object?> get createRoomGraphQLField =>
    _createRoomGraphQLField.value;
final _createRoomGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<RoomCreated, Object?, Object?>>(
        (setValue) => setValue(roomCreatedGraphQLType.nonNull().field<Object?>(
              'createRoom',
              resolve: (obj, ctx) {
                final args = ctx.args;

                final _call = (RoomEndpoints r) => r.createRoom(ctx);
                final FutureOr<RoomEndpoints>
                    _obj = // ignore: unnecessary_non_null_assertion
                    RoomEndpoints.ref.get(ctx)!;
                if (_obj is Future<RoomEndpoints>)
                  return _obj.then(_call);
                else
                  return _call(_obj);
              },
              description:
                  'Creates a room. You can use the RoomCreated.token for subscribing to events\nin eventsRoom or sharing it to other users.',
            )));

GraphQLObjectField<RoomCreated?, Object?, Object?>
    get resetTokenRoomGraphQLField => _resetTokenRoomGraphQLField.value;
final _resetTokenRoomGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<RoomCreated?, Object?, Object?>>(
        (setValue) => setValue(roomCreatedGraphQLType.field<Object?>(
              'resetTokenRoom',
              resolve: (obj, ctx) {
                final args = ctx.args;

                final _call = (RoomEndpoints r) =>
                    r.resetTokenRoom(ctx, (args["roomId"] as String));
                final FutureOr<RoomEndpoints>
                    _obj = // ignore: unnecessary_non_null_assertion
                    RoomEndpoints.ref.get(ctx)!;
                if (_obj is Future<RoomEndpoints>)
                  return _obj.then(_call);
                else
                  return _call(_obj);
              },
              description:
                  'Resets the token for the given roomId. Only the creator can reset the token.\nPrevious tokens will be invalidated.',
            ))
              ..inputs.addAll([graphQLString.nonNull().inputField('roomId')]));

GraphQLObjectField<RoomMessage, Object?, Object?>
    get sendMessageRoomGraphQLField => _sendMessageRoomGraphQLField.value;
final _sendMessageRoomGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<RoomMessage, Object?, Object?>>(
        (setValue) => setValue(roomMessageGraphQLType.nonNull().field<Object?>(
              'sendMessageRoom',
              resolve: (obj, ctx) {
                final args = ctx.args;

                final _call = (RoomEndpoints r) => r.sendMessageRoom(
                    ctx,
                    (args["roomId"] as String),
                    (args["content"] as String),
                    (args["recipientUserId"] as String?));
                final FutureOr<RoomEndpoints>
                    _obj = // ignore: unnecessary_non_null_assertion
                    RoomEndpoints.ref.get(ctx)!;
                if (_obj is Future<RoomEndpoints>)
                  return _obj.then(_call);
                else
                  return _call(_obj);
              },
              description:
                  'Sends a message with content to a room with roomId. You can direct it to a\nspecific user with recipientUserId.',
            ))
              ..inputs.addAll([
                graphQLString.nonNull().inputField('roomId'),
                graphQLString.nonNull().inputField('content'),
                graphQLString.inputField('recipientUserId')
              ]));

GraphQLObjectField<RoomEvent, Object?, Object?> get eventsRoomGraphQLField =>
    _eventsRoomGraphQLField.value;
final _eventsRoomGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<RoomEvent, Object?, Object?>>(
        (setValue) => setValue(roomEventGraphQLType.nonNull().field<Object?>(
              'eventsRoom',
              subscribe: (obj, ctx) {
                final args = ctx.args;

                final _call = (RoomEndpoints r) =>
                    r.eventsRoom(ctx, (args["token"] as String));
                final FutureOr<RoomEndpoints>
                    _obj = // ignore: unnecessary_non_null_assertion
                    RoomEndpoints.ref.get(ctx)!;
                if (_obj is Future<RoomEndpoints>)
                  return _obj.then(_call);
                else
                  return _call(_obj);
              },
              description:
                  'Subscribes to changes in user subscription and room messages.',
            ))
              ..inputs.addAll([graphQLString.nonNull().inputField('token')]));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final _roomGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<Room>>((setValue) {
  final __name = 'Room';

  final __roomGraphQLType =
      objectType<Room>(__name, isInterface: false, interfaces: []);

  setValue(__roomGraphQLType);
  __roomGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('roomId',
          resolve: (obj, ctx) => obj.roomId,
          description: 'Unique id of the room'),
      userGraphQLType.nonNull().list().nonNull().field('users',
          resolve: (obj, ctx) => obj.users,
          description: 'All users that are subscribed to room events'),
      graphQLDate.field('lastMessageDate',
          resolve: (obj, ctx) => obj.lastMessageDate,
          description:
              'The date of the last message may be null when no messages have been sent'),
      graphQLDate.nonNull().field('lastUpdateDate',
          resolve: (obj, ctx) => obj.lastUpdateDate,
          description: 'The last update to user subscriptions'),
      graphQLDate.nonNull().field('createdDate',
          resolve: (obj, ctx) => obj.createdDate,
          description: 'The date of creation of the room')
    ],
  );

  return __roomGraphQLType;
});

/// Auto-generated from [Room].
GraphQLObjectType<Room> get roomGraphQLType => _roomGraphQLType.value;

final _roomCreatedGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<RoomCreated>>((setValue) {
  final __name = 'RoomCreated';

  final __roomCreatedGraphQLType =
      objectType<RoomCreated>(__name, isInterface: false, interfaces: []);

  setValue(__roomCreatedGraphQLType);
  __roomCreatedGraphQLType.fields.addAll(
    [
      roomGraphQLType.nonNull().field('room', resolve: (obj, ctx) => obj.room),
      graphQLString.nonNull().field('token',
          resolve: (obj, ctx) => obj.token,
          description:
              'Can be used to subscribe to room events you may share it to other users.\nMay be reset with resetTokenRoom')
    ],
  );

  return __roomCreatedGraphQLType;
});

/// Auto-generated from [RoomCreated].
GraphQLObjectType<RoomCreated> get roomCreatedGraphQLType =>
    _roomCreatedGraphQLType.value;

final _roomMessageGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<RoomMessage>>((setValue) {
  final __name = 'RoomMessage';

  final __roomMessageGraphQLType = objectType<RoomMessage>(__name,
      isInterface: false, interfaces: [], description: 'A room message.');

  setValue(__roomMessageGraphQLType);
  __roomMessageGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('messageId',
          resolve: (obj, ctx) => obj.messageId,
          description: 'A unique id within the room'),
      graphQLString
          .nonNull()
          .field('roomId', resolve: (obj, ctx) => obj.roomId),
      graphQLString.nonNull().field('content',
          resolve: (obj, ctx) => obj.content,
          description: 'The main payload of the message.'),
      userGraphQLType.nonNull().field('user',
          resolve: (obj, ctx) => obj.user,
          description: 'The user that sent the message.'),
      graphQLDate.nonNull().field('createdDate',
          resolve: (obj, ctx) => obj.createdDate,
          description: 'The date when the message was created.'),
      graphQLString.field('recipientUserId',
          resolve: (obj, ctx) => obj.recipientUserId,
          description:
              'The user id to which this message was sent.\nNull if it was sent to all users in a room.')
    ],
  );

  return __roomMessageGraphQLType;
});

/// Auto-generated from [RoomMessage].
GraphQLObjectType<RoomMessage> get roomMessageGraphQLType =>
    _roomMessageGraphQLType.value;

/// Generated from [RoomEvent]
GraphQLUnionType<RoomEvent> get roomEventGraphQLType =>
    _roomEventGraphQLType.value;

final _roomEventGraphQLType =
    HotReloadableDefinition<GraphQLUnionType<RoomEvent>>((setValue) {
  final type = GraphQLUnionType<RoomEvent>(
    'RoomEvent',
    const [],
    description:
        'An event in a room. May be a message or a room with user subscription changes.',
  );
  setValue(type);
  type.possibleTypes.addAll([
    roomMessageGraphQLType,
    roomGraphQLType,
  ]);
  return type;
});
