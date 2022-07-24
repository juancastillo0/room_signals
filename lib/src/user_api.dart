import 'package:leto_schema/leto_schema.dart';

import 'auth.dart';
import 'util.dart';

part 'user_api.g.dart';

@GraphQLClass()
class User {
  final String userId;

  User({
    required this.userId,
  });
}

@GraphQLClass()
class UserCreated {
  final String token;
  final User user;

  UserCreated({
    required this.token,
    required this.user,
  });
}

@Query()
User getUser(Ctx ctx) {
  final token = getUserToken(ctx);
  if (token != null) {
    return userFromToken(token);
  }
  throw Exception('Unauthenticated');
}

@Mutation()
UserCreated createUser(Ctx ctx) {
  String? token = getUserToken(ctx);

  final User user;
  if (token == null) {
    user = User(userId: randomId());
    token = createToken(ctx, user);
  } else {
    user = getUser(ctx);
  }
  return UserCreated(
    token: token,
    user: user,
  );
}
