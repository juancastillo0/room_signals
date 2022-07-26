// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:room_signals_client/src/coercers.dart';
part 'graphql_api.graphql.g.dart';

mixin $UserMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String userId;
}
mixin $RoomMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String roomId;
  @JsonKey(
      fromJson: fromGraphQLDateNullableToDartDateTimeNullable,
      toJson: fromDartDateTimeNullableToGraphQLDateNullable)
  DateTime? lastMessageDate;
  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  late DateTime lastUpdateDate;
  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  late DateTime createdDate;
  late List<$RoomMixin$User> users;
}
mixin $RoomMessageMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String content;
  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  late DateTime createdDate;
  String? recipientUserId;
  late $RoomMessageMixin$User user;
}

@JsonSerializable(explicitToJson: true)
class CreateUser$Mutation$UserCreated$User extends JsonSerializable
    with EquatableMixin, $UserMixin {
  CreateUser$Mutation$UserCreated$User();

  factory CreateUser$Mutation$UserCreated$User.fromJson(
          Map<String, dynamic> json) =>
      _$CreateUser$Mutation$UserCreated$UserFromJson(json);

  @override
  List<Object?> get props => [$$typename, userId];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateUser$Mutation$UserCreated$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUser$Mutation$UserCreated extends JsonSerializable
    with EquatableMixin {
  CreateUser$Mutation$UserCreated();

  factory CreateUser$Mutation$UserCreated.fromJson(Map<String, dynamic> json) =>
      _$CreateUser$Mutation$UserCreatedFromJson(json);

  late String token;

  late CreateUser$Mutation$UserCreated$User user;

  @override
  List<Object?> get props => [token, user];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateUser$Mutation$UserCreatedToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUser$Mutation extends JsonSerializable with EquatableMixin {
  CreateUser$Mutation();

  factory CreateUser$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateUser$MutationFromJson(json);

  late CreateUser$Mutation$UserCreated createUser;

  @override
  List<Object?> get props => [createUser];
  @override
  Map<String, dynamic> toJson() => _$CreateUser$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUser$Query$User extends JsonSerializable
    with EquatableMixin, $UserMixin {
  GetUser$Query$User();

  factory GetUser$Query$User.fromJson(Map<String, dynamic> json) =>
      _$GetUser$Query$UserFromJson(json);

  @override
  List<Object?> get props => [$$typename, userId];
  @override
  Map<String, dynamic> toJson() => _$GetUser$Query$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUser$Query extends JsonSerializable with EquatableMixin {
  GetUser$Query();

  factory GetUser$Query.fromJson(Map<String, dynamic> json) =>
      _$GetUser$QueryFromJson(json);

  late GetUser$Query$User getUser;

  @override
  List<Object?> get props => [getUser];
  @override
  Map<String, dynamic> toJson() => _$GetUser$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetListRoom$Query$Room extends JsonSerializable
    with EquatableMixin, $RoomMixin {
  GetListRoom$Query$Room();

  factory GetListRoom$Query$Room.fromJson(Map<String, dynamic> json) =>
      _$GetListRoom$Query$RoomFromJson(json);

  @override
  List<Object?> get props =>
      [$$typename, roomId, lastMessageDate, lastUpdateDate, createdDate, users];
  @override
  Map<String, dynamic> toJson() => _$GetListRoom$Query$RoomToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetListRoom$Query extends JsonSerializable with EquatableMixin {
  GetListRoom$Query();

  factory GetListRoom$Query.fromJson(Map<String, dynamic> json) =>
      _$GetListRoom$QueryFromJson(json);

  late List<GetListRoom$Query$Room> getListRoom;

  @override
  List<Object?> get props => [getListRoom];
  @override
  Map<String, dynamic> toJson() => _$GetListRoom$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class $RoomMixin$User extends JsonSerializable with EquatableMixin, $UserMixin {
  $RoomMixin$User();

  factory $RoomMixin$User.fromJson(Map<String, dynamic> json) =>
      _$$RoomMixin$UserFromJson(json);

  @override
  List<Object?> get props => [$$typename, userId];
  @override
  Map<String, dynamic> toJson() => _$$RoomMixin$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateRoom$Mutation$RoomCreated$Room extends JsonSerializable
    with EquatableMixin, $RoomMixin {
  CreateRoom$Mutation$RoomCreated$Room();

  factory CreateRoom$Mutation$RoomCreated$Room.fromJson(
          Map<String, dynamic> json) =>
      _$CreateRoom$Mutation$RoomCreated$RoomFromJson(json);

  @override
  List<Object?> get props =>
      [$$typename, roomId, lastMessageDate, lastUpdateDate, createdDate, users];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateRoom$Mutation$RoomCreated$RoomToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateRoom$Mutation$RoomCreated extends JsonSerializable
    with EquatableMixin {
  CreateRoom$Mutation$RoomCreated();

  factory CreateRoom$Mutation$RoomCreated.fromJson(Map<String, dynamic> json) =>
      _$CreateRoom$Mutation$RoomCreatedFromJson(json);

  late String token;

  late CreateRoom$Mutation$RoomCreated$Room room;

  @override
  List<Object?> get props => [token, room];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateRoom$Mutation$RoomCreatedToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateRoom$Mutation extends JsonSerializable with EquatableMixin {
  CreateRoom$Mutation();

  factory CreateRoom$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateRoom$MutationFromJson(json);

  late CreateRoom$Mutation$RoomCreated createRoom;

  @override
  List<Object?> get props => [createRoom];
  @override
  Map<String, dynamic> toJson() => _$CreateRoom$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SendMessageRoom$Mutation$RoomMessage extends JsonSerializable
    with EquatableMixin, $RoomMessageMixin {
  SendMessageRoom$Mutation$RoomMessage();

  factory SendMessageRoom$Mutation$RoomMessage.fromJson(
          Map<String, dynamic> json) =>
      _$SendMessageRoom$Mutation$RoomMessageFromJson(json);

  @override
  List<Object?> get props =>
      [$$typename, content, createdDate, recipientUserId, user];
  @override
  Map<String, dynamic> toJson() =>
      _$SendMessageRoom$Mutation$RoomMessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SendMessageRoom$Mutation extends JsonSerializable with EquatableMixin {
  SendMessageRoom$Mutation();

  factory SendMessageRoom$Mutation.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRoom$MutationFromJson(json);

  late SendMessageRoom$Mutation$RoomMessage sendMessageRoom;

  @override
  List<Object?> get props => [sendMessageRoom];
  @override
  Map<String, dynamic> toJson() => _$SendMessageRoom$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class $RoomMessageMixin$User extends JsonSerializable
    with EquatableMixin, $UserMixin {
  $RoomMessageMixin$User();

  factory $RoomMessageMixin$User.fromJson(Map<String, dynamic> json) =>
      _$$RoomMessageMixin$UserFromJson(json);

  @override
  List<Object?> get props => [$$typename, userId];
  @override
  Map<String, dynamic> toJson() => _$$RoomMessageMixin$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EventsRoom$Subscription$RoomEvent$Room
    extends EventsRoom$Subscription$RoomEvent with EquatableMixin, $RoomMixin {
  EventsRoom$Subscription$RoomEvent$Room();

  factory EventsRoom$Subscription$RoomEvent$Room.fromJson(
          Map<String, dynamic> json) =>
      _$EventsRoom$Subscription$RoomEvent$RoomFromJson(json);

  @override
  List<Object?> get props =>
      [$$typename, roomId, lastMessageDate, lastUpdateDate, createdDate, users];
  @override
  Map<String, dynamic> toJson() =>
      _$EventsRoom$Subscription$RoomEvent$RoomToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EventsRoom$Subscription$RoomEvent$RoomMessage
    extends EventsRoom$Subscription$RoomEvent
    with EquatableMixin, $RoomMessageMixin {
  EventsRoom$Subscription$RoomEvent$RoomMessage();

  factory EventsRoom$Subscription$RoomEvent$RoomMessage.fromJson(
          Map<String, dynamic> json) =>
      _$EventsRoom$Subscription$RoomEvent$RoomMessageFromJson(json);

  @override
  List<Object?> get props =>
      [$$typename, content, createdDate, recipientUserId, user];
  @override
  Map<String, dynamic> toJson() =>
      _$EventsRoom$Subscription$RoomEvent$RoomMessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EventsRoom$Subscription$RoomEvent extends JsonSerializable
    with EquatableMixin {
  EventsRoom$Subscription$RoomEvent();

  factory EventsRoom$Subscription$RoomEvent.fromJson(
      Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case r'Room':
        return EventsRoom$Subscription$RoomEvent$Room.fromJson(json);
      case r'RoomMessage':
        return EventsRoom$Subscription$RoomEvent$RoomMessage.fromJson(json);
      default:
    }
    return _$EventsRoom$Subscription$RoomEventFromJson(json);
  }

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [$$typename];
  @override
  Map<String, dynamic> toJson() {
    switch ($$typename) {
      case r'Room':
        return (this as EventsRoom$Subscription$RoomEvent$Room).toJson();
      case r'RoomMessage':
        return (this as EventsRoom$Subscription$RoomEvent$RoomMessage).toJson();
      default:
    }
    return _$EventsRoom$Subscription$RoomEventToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class EventsRoom$Subscription extends JsonSerializable with EquatableMixin {
  EventsRoom$Subscription();

  factory EventsRoom$Subscription.fromJson(Map<String, dynamic> json) =>
      _$EventsRoom$SubscriptionFromJson(json);

  late EventsRoom$Subscription$RoomEvent eventsRoom;

  @override
  List<Object?> get props => [eventsRoom];
  @override
  Map<String, dynamic> toJson() => _$EventsRoom$SubscriptionToJson(this);
}

final CREATE_USER_MUTATION_DOCUMENT_OPERATION_NAME = 'createUser';
final CREATE_USER_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createUser'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createUser'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'token'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: '_User'), directives: [])
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: '_User'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'userId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateUserMutation
    extends GraphQLQuery<CreateUser$Mutation, JsonSerializable> {
  CreateUserMutation();

  @override
  final DocumentNode document = CREATE_USER_MUTATION_DOCUMENT;

  @override
  final String operationName = CREATE_USER_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  List<Object?> get props => [document, operationName];
  @override
  CreateUser$Mutation parse(Map<String, dynamic> json) =>
      CreateUser$Mutation.fromJson(json);
}

final GET_USER_QUERY_DOCUMENT_OPERATION_NAME = 'getUser';
final GET_USER_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'getUser'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'getUser'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(name: NameNode(value: '_User'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: '_User'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'userId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class GetUserQuery extends GraphQLQuery<GetUser$Query, JsonSerializable> {
  GetUserQuery();

  @override
  final DocumentNode document = GET_USER_QUERY_DOCUMENT;

  @override
  final String operationName = GET_USER_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  List<Object?> get props => [document, operationName];
  @override
  GetUser$Query parse(Map<String, dynamic> json) =>
      GetUser$Query.fromJson(json);
}

final GET_LIST_ROOM_QUERY_DOCUMENT_OPERATION_NAME = 'getListRoom';
final GET_LIST_ROOM_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'getListRoom'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'getListRoom'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(name: NameNode(value: '_Room'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: '_Room'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Room'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roomId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'lastMessageDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'lastUpdateDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'users'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(name: NameNode(value: '_User'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: '_User'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'userId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class GetListRoomQuery
    extends GraphQLQuery<GetListRoom$Query, JsonSerializable> {
  GetListRoomQuery();

  @override
  final DocumentNode document = GET_LIST_ROOM_QUERY_DOCUMENT;

  @override
  final String operationName = GET_LIST_ROOM_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  List<Object?> get props => [document, operationName];
  @override
  GetListRoom$Query parse(Map<String, dynamic> json) =>
      GetListRoom$Query.fromJson(json);
}

final CREATE_ROOM_MUTATION_DOCUMENT_OPERATION_NAME = 'createRoom';
final CREATE_ROOM_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createRoom'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createRoom'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'token'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'room'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: '_Room'), directives: [])
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: '_Room'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Room'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roomId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'lastMessageDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'lastUpdateDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'users'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(name: NameNode(value: '_User'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: '_User'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'userId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateRoomMutation
    extends GraphQLQuery<CreateRoom$Mutation, JsonSerializable> {
  CreateRoomMutation();

  @override
  final DocumentNode document = CREATE_ROOM_MUTATION_DOCUMENT;

  @override
  final String operationName = CREATE_ROOM_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  List<Object?> get props => [document, operationName];
  @override
  CreateRoom$Mutation parse(Map<String, dynamic> json) =>
      CreateRoom$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SendMessageRoomArguments extends JsonSerializable with EquatableMixin {
  SendMessageRoomArguments(
      {required this.roomId, required this.content, this.recipientUserId});

  @override
  factory SendMessageRoomArguments.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRoomArgumentsFromJson(json);

  late String roomId;

  late String content;

  final String? recipientUserId;

  @override
  List<Object?> get props => [roomId, content, recipientUserId];
  @override
  Map<String, dynamic> toJson() => _$SendMessageRoomArgumentsToJson(this);
}

final SEND_MESSAGE_ROOM_MUTATION_DOCUMENT_OPERATION_NAME = 'sendMessageRoom';
final SEND_MESSAGE_ROOM_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'sendMessageRoom'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'roomId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'content')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'recipientUserId')),
            type: NamedTypeNode(
                name: NameNode(value: 'String'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'sendMessageRoom'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'roomId'),
                  value: VariableNode(name: NameNode(value: 'roomId'))),
              ArgumentNode(
                  name: NameNode(value: 'content'),
                  value: VariableNode(name: NameNode(value: 'content'))),
              ArgumentNode(
                  name: NameNode(value: 'recipientUserId'),
                  value: VariableNode(name: NameNode(value: 'recipientUserId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: '_RoomMessage'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: '_RoomMessage'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'RoomMessage'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'content'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'recipientUserId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(name: NameNode(value: '_User'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: '_User'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'userId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class SendMessageRoomMutation
    extends GraphQLQuery<SendMessageRoom$Mutation, SendMessageRoomArguments> {
  SendMessageRoomMutation({required this.variables});

  @override
  final DocumentNode document = SEND_MESSAGE_ROOM_MUTATION_DOCUMENT;

  @override
  final String operationName =
      SEND_MESSAGE_ROOM_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final SendMessageRoomArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SendMessageRoom$Mutation parse(Map<String, dynamic> json) =>
      SendMessageRoom$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class EventsRoomArguments extends JsonSerializable with EquatableMixin {
  EventsRoomArguments({required this.token});

  @override
  factory EventsRoomArguments.fromJson(Map<String, dynamic> json) =>
      _$EventsRoomArgumentsFromJson(json);

  late String token;

  @override
  List<Object?> get props => [token];
  @override
  Map<String, dynamic> toJson() => _$EventsRoomArgumentsToJson(this);
}

final EVENTS_ROOM_SUBSCRIPTION_DOCUMENT_OPERATION_NAME = 'eventsRoom';
final EVENTS_ROOM_SUBSCRIPTION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'eventsRoom'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'token')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'eventsRoom'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'token'),
                  value: VariableNode(name: NameNode(value: 'token')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              InlineFragmentNode(
                  typeCondition: TypeConditionNode(
                      on: NamedTypeNode(
                          name: NameNode(value: 'Room'), isNonNull: false)),
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: '_Room'), directives: [])
                  ])),
              InlineFragmentNode(
                  typeCondition: TypeConditionNode(
                      on: NamedTypeNode(
                          name: NameNode(value: 'RoomMessage'),
                          isNonNull: false)),
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: '_RoomMessage'), directives: [])
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: '_Room'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Room'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roomId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'lastMessageDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'lastUpdateDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'users'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(name: NameNode(value: '_User'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: '_User'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'userId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: '_RoomMessage'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'RoomMessage'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'content'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'recipientUserId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(name: NameNode(value: '_User'), directives: [])
            ]))
      ]))
]);

class EventsRoomSubscription
    extends GraphQLQuery<EventsRoom$Subscription, EventsRoomArguments> {
  EventsRoomSubscription({required this.variables});

  @override
  final DocumentNode document = EVENTS_ROOM_SUBSCRIPTION_DOCUMENT;

  @override
  final String operationName = EVENTS_ROOM_SUBSCRIPTION_DOCUMENT_OPERATION_NAME;

  @override
  final EventsRoomArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  EventsRoom$Subscription parse(Map<String, dynamic> json) =>
      EventsRoom$Subscription.fromJson(json);
}
