import 'package:leto_schema/leto_schema.dart';

import 'auth.dart';
import 'util.dart';

part 'user_api.g.dart';

@GraphQLClass()
class User {
  /// A unique user id
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
  /// The user token. You may save this, but do not share it.
  /// View getUser query documentation for more info.
  final String token;
  final User user;

  UserCreated({
    required this.token,
    required this.user,
  });
}

/// Returns the currently authenticated user.
/// Throws "unauthenticated" if the user is not authenticated.
/// You may pass the user token as header, url query parameter or as a value
/// in the initial connection payload for web sockets.
/// The key of the value should be "room-signals-auth".
@Query()
User getUser(Ctx ctx) {
  final token = getUserToken(ctx);
  if (token != null) {
    return userFromToken(ctx, token);
  }
  throw UserError(UserErrorCode.unauthenticated, 'Unauthenticated');
}

/// Returns the currently authenticated user or creates a new one.
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

enum UserErrorCode {
  unauthorized,
  unauthenticated,
}

class UserError extends AppError {
  @override
  final UserErrorCode code;
  @override
  final String message;

  UserError(
    this.code,
    this.message, {
    StackTrace? stackTrace,
  }) : super(stackTrace: stackTrace);
}
