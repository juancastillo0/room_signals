import 'dart:io';

import 'package:leto/leto.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:room_signals/graphql_api.schema.dart';
import 'package:room_signals/src/auth.dart';
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
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;
  // For running in containers, we respect the PORT environment variable.
  final adminPassword = Platform.environment['ADMIN_PASSWORD'];
  final environment = Platform.environment['ENVIRONMENT'] ?? 'DEVELOPMENT';
  final host = Platform.environment['HOST'] ?? 'localhost';
  final isSecure = host != 'localhost' && environment == 'PRODUCTION';
  final port = int.parse(Platform.environment['PORT'] ?? '6394');

  const graphqlPath = 'graphql';
  const graphqlSubscriptionPath = '$graphqlPath-subscription';
  final endpoint = 'http${isSecure ? 's' : ''}://$host:$port/$graphqlPath';
  final subscriptionEndpoint =
      'ws${isSecure ? 's' : ''}://$host:$port/$graphqlSubscriptionPath';

  final graphQLExecutor = GraphQL(graphqlApiSchema);

  // Configure routes.
  final router = Router()
    ..get('/', _rootHandler)
    ..get('/echo/<message>', _echoHandler)
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
  // Simple endpoint to download the GraphQLSchema as a SDL file.
  // $ curl http://localhost:6394/graphql-schema > schema.graphql
  const downloadSchemaOnOpen = false;
  const schemaFilename = 'schema.graphql';
  router.get('/$graphqlPath-schema', (Request request) {
    return Response.ok(
      graphQLExecutor.schema.schemaStr,
      headers: {
        'content-type': 'text/plain',
        'content-disposition': downloadSchemaOnOpen
            ? 'attachment; filename="$schemaFilename"'
            : 'inline',
      },
    );
  });

  _addGraphQLExplorers(
    router,
    graphqlPath: graphqlPath,
    endpoint: endpoint,
    subscriptionEndpoint: subscriptionEndpoint,
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

void _addGraphQLExplorers(
  Router router, {
  required String graphqlPath,
  required String endpoint,
  required String subscriptionEndpoint,
}) {
  router
    ..get(
      '/$graphqlPath-altair',
      altairHandler(
        config: AltairConfig(
          endpointURL: endpoint,
          subscriptionsEndpoint: subscriptionEndpoint,
        ),
      ),
    )
    ..get(
      '/$graphqlPath-playground',
      playgroundHandler(
        config: PlaygroundConfig(
          endpoint: endpoint,
          subscriptionEndpoint: subscriptionEndpoint,
        ),
      ),
    )
    ..get(
      '/$graphqlPath-graphiql',
      graphiqlHandler(
        fetcher: GraphiqlFetcher(
          url: endpoint,
          subscriptionUrl: subscriptionEndpoint,
        ),
      ),
    );
}
