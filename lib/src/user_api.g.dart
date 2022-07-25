// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<User, Object?, Object?> get getUserGraphQLField =>
    _getUserGraphQLField.value;
final _getUserGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<User, Object?, Object?>>(
        (setValue) => setValue(userGraphQLType.nonNull().field<Object?>(
              'getUser',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return getUser(ctx);
              },
              description:
                  'Returns the currently authenticated user.\nThrows "unauthenticated" if the user is not authenticated.\nYou may pass the user token as header, url query parameter or as a value\nin the initial connection payload for web sockets.\nThe key of the value should be "room-signals-auth".',
            )));

GraphQLObjectField<UserCreated, Object?, Object?> get createUserGraphQLField =>
    _createUserGraphQLField.value;
final _createUserGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<UserCreated, Object?, Object?>>(
        (setValue) => setValue(userCreatedGraphQLType.nonNull().field<Object?>(
              'createUser',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return createUser(ctx);
              },
              description:
                  'Returns the currently authenticated user or creates a new one.',
            )));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final _userGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<User>>((setValue) {
  final __name = 'User';

  final __userGraphQLType =
      objectType<User>(__name, isInterface: false, interfaces: []);

  setValue(__userGraphQLType);
  __userGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('userId',
          resolve: (obj, ctx) => obj.userId, description: 'A unique user id')
    ],
  );

  return __userGraphQLType;
});

/// Auto-generated from [User].
GraphQLObjectType<User> get userGraphQLType => _userGraphQLType.value;

final _userCreatedGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UserCreated>>((setValue) {
  final __name = 'UserCreated';

  final __userCreatedGraphQLType =
      objectType<UserCreated>(__name, isInterface: false, interfaces: []);

  setValue(__userCreatedGraphQLType);
  __userCreatedGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('token',
          resolve: (obj, ctx) => obj.token,
          description:
              'The user token. You may save this, but do not share it.\nView getUser query documentation for more info.'),
      userGraphQLType.nonNull().field('user', resolve: (obj, ctx) => obj.user)
    ],
  );

  return __userCreatedGraphQLType;
});

/// Auto-generated from [UserCreated].
GraphQLObjectType<UserCreated> get userCreatedGraphQLType =>
    _userCreatedGraphQLType.value;
