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
  const bool kReleaseMode = bool.fromEnvironment(
    'dart.vm.product',
    defaultValue: false,
  );

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;
  // For running in containers, we respect the PORT environment variable.
  final adminPassword = Platform.environment['ADMIN_PASSWORD'];
  final environment = AppEnvironment.values.byName(
    (Platform.environment['ENVIRONMENT'] ?? 'development').toLowerCase(),
  );
  final host = Platform.environment['HOST'] ?? 'localhost';
  final isSecure = host != 'localhost' && environment.isProduction;
  final port = int.parse(Platform.environment['PORT'] ?? '6394');

  const graphqlPath = 'graphql';
  const graphqlSubscriptionPath = '$graphqlPath-subscription';
  final endpoint = 'http${isSecure ? 's' : ''}://$host:$port/$graphqlPath';
  final subscriptionEndpoint =
      'ws${isSecure ? 's' : ''}://$host:$port/$graphqlSubscriptionPath';

  final graphQLExecutor = GraphQL(
    graphqlApiSchema,
    customValidationRules: [
      queryComplexityRuleBuilder(maxComplexity: 1000, maxDepth: 4),
    ],
    extensions: [
      if (const bool.fromEnvironment('TRACING'))
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
    ..all('/$graphqlPath', graphQLHttp(graphQLExecutor))
    ..all(
      '/$graphqlSubscriptionPath',
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
    graphqlPath: graphqlPath,
    endpoint: endpoint,
    subscriptionEndpoint: subscriptionEndpoint,
  );
  setUpGraphQLSchemaDefinition(
    router,
    graphQLExecutor.schema,
    appTitle: 'Room Signals',
    appDescription:
        'A simple web socket enabled GraphQL server for managing rooms and'
        ' message subscriptions. Using GraphQL Leto Dart server libraries.',
  );

  // Configure a pipeline that logs requests.
  final handler = Pipeline()
      .addMiddleware(customLog())
      .addMiddleware(cors())
      .addMiddleware(etag())
      .addMiddleware(jsonParse())
      .addHandler(router);

  final server = await serve(handler, ip, port);
  print(
    'Server listening at "$endpoint" subscriptions at "$subscriptionEndpoint"',
  );
}
