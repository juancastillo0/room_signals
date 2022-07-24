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
                // ignore: unnecessary_non_null_assertion
                final FutureOr<RoomEndpoints> _obj =
                    RoomEndpoints.ref.get(ctx)!;
                if (_obj is Future<RoomEndpoints>)
                  return _obj.then(_call);
                else
                  return _call(_obj);
              },
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
                // ignore: unnecessary_non_null_assertion
                final FutureOr<RoomEndpoints> _obj =
                    RoomEndpoints.ref.get(ctx)!;
                if (_obj is Future<RoomEndpoints>)
                  return _obj.then(_call);
                else
                  return _call(_obj);
              },
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
                // ignore: unnecessary_non_null_assertion
                final FutureOr<RoomEndpoints> _obj =
                    RoomEndpoints.ref.get(ctx)!;
                if (_obj is Future<RoomEndpoints>)
                  return _obj.then(_call);
                else
                  return _call(_obj);
              },
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
                // ignore: unnecessary_non_null_assertion
                final FutureOr<RoomEndpoints> _obj =
                    RoomEndpoints.ref.get(ctx)!;
                if (_obj is Future<RoomEndpoints>)
                  return _obj.then(_call);
                else
                  return _call(_obj);
              },
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
                // ignore: unnecessary_non_null_assertion
                final FutureOr<RoomEndpoints> _obj =
                    RoomEndpoints.ref.get(ctx)!;
                if (_obj is Future<RoomEndpoints>)
                  return _obj.then(_call);
                else
                  return _call(_obj);
              },
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
      graphQLString
          .nonNull()
          .field('roomId', resolve: (obj, ctx) => obj.roomId),
      userGraphQLType
          .nonNull()
          .list()
          .nonNull()
          .field('users', resolve: (obj, ctx) => obj.users),
      graphQLDate.field('lastMessageDate',
          resolve: (obj, ctx) => obj.lastMessageDate),
      graphQLDate
          .nonNull()
          .field('lastUpdateDate', resolve: (obj, ctx) => obj.lastUpdateDate),
      graphQLDate
          .nonNull()
          .field('createdDate', resolve: (obj, ctx) => obj.createdDate)
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
      graphQLString.nonNull().field('token', resolve: (obj, ctx) => obj.token)
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

  final __roomMessageGraphQLType =
      objectType<RoomMessage>(__name, isInterface: false, interfaces: []);

  setValue(__roomMessageGraphQLType);
  __roomMessageGraphQLType.fields.addAll(
    [
      graphQLString
          .nonNull()
          .field('content', resolve: (obj, ctx) => obj.content),
      userGraphQLType.nonNull().field('user', resolve: (obj, ctx) => obj.user),
      graphQLDate
          .nonNull()
          .field('createdDate', resolve: (obj, ctx) => obj.createdDate),
      graphQLString.field('recipientUserId',
          resolve: (obj, ctx) => obj.recipientUserId)
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
  );
  setValue(type);
  type.possibleTypes.addAll([
    roomMessageGraphQLType,
    roomGraphQLType,
  ]);
  return type;
});
