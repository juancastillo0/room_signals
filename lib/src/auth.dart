// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';

import 'user_api.dart';

/// May throw JWTError
User userFromToken(Ctx ctx, String token) {
  // throw JWTError
  final jwt = JWT.verify(
    token,
    SecretKey(_JWT_SECRET),
    issuer: _JWT_ISSUER,
    checkExpiresIn: true,
  );
  final reqData = UserReqData.fromCtx(ctx);
  final payload = jwt.payload as Map;
  return User(
    name: payload['name'] as String?,
    userId: jwt.subject!,
    reqData: reqData,
  );
}

String createToken(Ctx ctx, User user) {
  final jwt = JWT(
    {
      'userId': user.userId,
      'name': user.name,
      'reqData': user.reqData.toJson(),
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
// ignore: non_constant_identifier_names
final _JWT_SECRET = Platform.environment['JWT_SECRET'] ?? 'secret passphrase';
const _AUTH_HEADER = 'room-signals-auth';

String? getUserToken(Ctx ctx) {
  final userToken = _UserToken.ref.get(ctx);
  userToken.token ??= ctx.request.headers[_AUTH_HEADER];
  userToken.token ??= ctx.request.url.queryParameters[_AUTH_HEADER];

  return userToken.token;
}

Map<Object, Object?> setUserTokenOverrides(Map<String, Object?> payload) {
  final token = payload[_AUTH_HEADER] as String?;
  return {_UserToken.ref: _UserToken(token: token)};
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

const _X_Forwarded_For = 'X-Forwarded-For';
const _X_Real_IP = 'X-Real-IP';
const _X_Forwarded_Host = 'X-Forwarded-Host';

class UserReqData {
  final List<String> forwarded;
  final String ip;
  final String userAgent;
  final String host;

  UserReqData({
    required this.forwarded,
    required this.ip,
    required this.userAgent,
    required this.host,
  });

  static final _ref =
      RefWithDefault.scoped((scope) => MutVal<UserReqData>(null));

  factory UserReqData.fromCtx(Ctx ctx) {
    final refVal = _ref.get(ctx);
    if (refVal.value != null) return refVal.value!;

    final headers = ctx.request.headers;
    final connectionInfo =
        ctx.request.context['shelf.io.connection_info'] as HttpConnectionInfo;
    final remoteAddress = connectionInfo.remoteAddress;

    final forwarded =
        ctx.request.headersAll[_X_Forwarded_For] ?? [remoteAddress.address];
    final ip = headers[_X_Real_IP] ?? remoteAddress.address;
    final userAgent = headers[HttpHeaders.userAgentHeader] ?? '';
    final host = headers[_X_Forwarded_Host] ?? remoteAddress.host;

    final value = UserReqData(
      forwarded: forwarded,
      host: host,
      ip: ip,
      userAgent: userAgent,
    );
    refVal.value = value;
    return value;
  }

  Map<String, dynamic> toJson() {
    return {
      'forwarded': forwarded,
      'ip': ip,
      'userAgent': userAgent,
      'host': host,
    };
  }

  factory UserReqData.fromJson(Map<String, dynamic> map) {
    return UserReqData(
      forwarded: List<String>.from(map['forwarded'] as List),
      ip: map['ip'] as String,
      userAgent: map['userAgent'] as String,
      host: map['host'] as String,
    );
  }
}

class MutVal<T> {
  T? value;

  MutVal(this.value);
}
