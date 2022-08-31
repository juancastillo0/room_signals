import 'package:leto_schema/leto_schema.dart';
import 'package:valida/valida.dart';

import 'auth.dart';
import 'util.dart';

part 'user_api.g.dart';

@GraphQLObject()
class User {
  /// A unique user id
  final String userId;

  /// An optional name for the user
  final String? name;

  @GraphQLField(omit: true)
  final UserReqData reqData;

  User({
    required this.name,
    required this.userId,
    required this.reqData,
  });
}

@GraphQLObject()
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
@Valida()
@Mutation()
UserCreated createUser(
  Ctx ctx,
  @ValidaString(minLength: 2) String? name,
) {
  String? token = getUserToken(ctx);

  User? user = token == null ? null : getUser(ctx);
  if (token == null || user == null || user.name != name) {
    final reqData = UserReqData.fromCtx(ctx);
    user = User(
      name: name,
      userId: user?.userId ?? randomId(),
      reqData: reqData,
    );
    token = createToken(ctx, user);
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
