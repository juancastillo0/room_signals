import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';

import 'user_api.dart';

User userFromToken(String token) {
  final jwt = JWT.verify(
    token,
    SecretKey(_JWT_SECRET),
    issuer: _JWT_ISSUER,
    checkExpiresIn: true,
  );

  return User(userId: jwt.subject!);
}

String createToken(Ctx ctx, User user) {
  final jwt = JWT(
    {
      'userId': user.userId,
    },
    issuer: _JWT_ISSUER,
    subject: user.userId,
  );
  final token = jwt.sign(
    SecretKey(_JWT_SECRET),
    algorithm: JWTAlgorithm.HS256,
    expiresIn: null,
  );

  _UserToken.ref.get(ctx).token = token;
  return token;
}

const _JWT_ISSUER = 'room_signals';
const _JWT_SECRET = String.fromEnvironment(
  'JWT_SECRET',
  defaultValue: 'secret passphrase',
);
const _AUTH_HEADER = 'room_signals-auth';

String? getUserToken(Ctx ctx) {
  final userToken = _UserToken.ref.get(ctx);
  userToken.token ??= ctx.request.headers[_AUTH_HEADER];
  userToken.token ??= ctx.request.url.queryParameters[_AUTH_HEADER];

  return userToken.token;
}

Map<Object, Object?> setUserTokenOverrides(String value) {
  return {_UserToken.ref: _UserToken(token: value)};
}

class _UserToken {
  String? token;

  _UserToken({
    this.token,
  });

  static final ref = RefWithDefault.scoped(
    (scope) => _UserToken(),
  );
}
