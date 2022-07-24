import 'package:leto_schema/leto_schema.dart';

import 'auth.dart';
import 'util.dart';

part 'user_api.g.dart';

@GraphQLClass()
class User {
  final String userId;

  @GraphQLField(omit: true)
  final UserReqData reqData;

  User({
    required this.userId,
    required this.reqData,
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
    return userFromToken(ctx, token);
  }
  throw UserException(UserExceptionCode.unauthenticated, 'Unauthenticated');
}

@Mutation()
UserCreated createUser(Ctx ctx) {
  String? token = getUserToken(ctx);

  final User user;
  if (token == null) {
    final reqData = UserReqData.fromCtx(ctx);
    user = User(
      userId: randomId(),
      reqData: reqData,
    );
    token = createToken(ctx, user);
  } else {
    user = getUser(ctx);
  }
  return UserCreated(
    token: token,
    user: user,
  );
}

enum UserExceptionCode {
  unauthorized,
  unauthenticated,
}

class UserException implements Exception {
  final UserExceptionCode code;
  final String message;

  UserException(
    this.code,
    this.message,
  );
}
