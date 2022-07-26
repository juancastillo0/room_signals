import 'dart:io';

import 'package:leto/leto.dart';
import 'package:leto_schema/validate_rules.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:room_signals/graphql_api.schema.dart';
import 'package:room_signals/src/auth.dart';
import 'package:room_signals/src/graphql_html.dart';
import 'package:room_signals/src/server_config.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

Response _rootHandler(Request req) {
  return Response.ok(
    '''
<h1>Room Signals</h1>
<h3><a href="https://github.com/juancastillo0/leto">GraphQL Leto Dart server libraries example</a></h3>
<p>A simple web socket enabled GraphQL server for managing rooms and message subscriptions.</p>
<ul>
<li><a href="/graphql-schema">Schema</a></li>
<li><a href="/graphql-schema-interactive">Schema Interactive</a></li>
<li><a href="/graphql-altair">Altair</a></li>
<li><a href="/graphql-playground">Playground</a></li>
<li><a href="/graphql-graphiql">GraphiQL</a></li>
<li><a href="https://github.com/juancastillo0/room_signals">Github Code Repository</a></li>
</ul>
''',
    headers: {HttpHeaders.contentTypeHeader: 'text/html'},
  );
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  await startServer();
}

class ServerConfig {
  ServerConfig({
    required this.environment,
    required int port,
    this.endpointHost = 'localhost',
    this.adminPassword,
    this.graphqlPath = 'graphql',
  }) : _port = port;

  ServerConfig.fromEnv({this.graphqlPath = 'graphql'})
      : adminPassword = Platform.environment['ADMIN_PASSWORD'],
        environment = AppEnvironment.values.byName(
          Platform.environment['ENVIRONMENT'] ?? 'development',
        ),
        endpointHost = Platform.environment['HOST'] ?? 'localhost',
        _port = int.parse(Platform.environment['PORT'] ?? '6394');

  static const bool kReleaseMode = bool.fromEnvironment('dart.vm.product');
  static const bool kProfileMode = bool.fromEnvironment('dart.vm.profile');
  static const bool kDebugMode = !kReleaseMode && !kProfileMode;

  final String? adminPassword;
  final AppEnvironment environment;
  final String endpointHost;
  int _port;
  int get port => _port;

  bool get isSecure => endpointHost != 'localhost' && environment.isProduction;
  String get _portStr => isSecure ? '' : ':$port';

  final String graphqlPath;
  String get graphqlSubscriptionPath => '$graphqlPath-subscription';

  String get endpoint =>
      'http${isSecure ? 's' : ''}://$endpointHost$_portStr/$graphqlPath';
  String get subscriptionEndpoint =>
      'ws${isSecure ? 's' : ''}://$endpointHost$_portStr/$graphqlSubscriptionPath';
}

Router makeServerRouter(ServerConfig config) {
  final graphQLExecutor = GraphQL(
    graphqlApiSchema,
    customValidationRules: [
      queryComplexityRuleBuilder(maxComplexity: 1000, maxDepth: 4),
    ],
    extensions: [
      if (Platform.environment['GRAPHQL_TRACING'] == 'true')
        GraphQLTracingExtension(
          returnInResponse: true,
        ),
      GraphQLPersistedQueries(returnHashInResponse: true),
      CacheExtension(cache: LruCacheSimple(50)),
      LoggingExtension((log) {
        if (log.operationName != 'IntrospectionQuery') {
          print(log);
        }
      }),
    ],
  );

  // Configure routes.
  final router = Router()
    ..get('/', _rootHandler)
    ..get('/echo/<message>', _echoHandler)
    ..get('/ping', (_) => Response.ok(DateTime.now().toIso8601String()))
    ..all('/${config.graphqlPath}', graphQLHttp(graphQLExecutor))
    ..all(
      '/${config.graphqlSubscriptionPath}',
      graphQLWebSocket(
        graphQLExecutor,
        validateIncomingConnection: (payload, server) {
          if (payload != null) {
            server.globalVariables.addAll(setUserTokenOverrides(payload));
          }
          return true;
        },
      ),
    );

  setUpGraphQLExplorers(
    router,
    graphqlPath: config.graphqlPath,
    endpoint: config.endpoint,
    subscriptionEndpoint: config.subscriptionEndpoint,
  );
  setUpGraphQLSchemaDefinition(
    router,
    graphQLExecutor.schema,
    appTitle: 'Room Signals',
    appDescription:
        'A simple web socket enabled GraphQL server for managing rooms and'
        ' message subscriptions. Using GraphQL Leto Dart server libraries.',
  );
  return router;
}

Future<HttpServer> startServer({ServerConfig? config}) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;
  config ??= ServerConfig.fromEnv();

  final server = await HttpServer.bind(ip, config.port);
  config._port = server.port;
  final router = makeServerRouter(config);

  // Configure a pipeline that logs requests.
  final handler = Pipeline()
      .addMiddleware(customLog())
      .addMiddleware(cors())
      .addMiddleware(etag())
      .addMiddleware(jsonParse())
      .addHandler(router);

  serveRequests(server, handler);
  print(
    'Server listening at "${config.endpoint}" subscriptions at "${config.subscriptionEndpoint}"',
  );
  return server;
}
