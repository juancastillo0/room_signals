import 'dart:io';

import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/utilities.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:shelf_router/shelf_router.dart';

void setUpGraphQLSchemaDefinition(
  Router app,
  GraphQLSchema schema, {
  required String appTitle,
  String? appDescription,
  bool downloadSchemaOnOpen = true,
  String schemaFilename = 'schema.graphql',
}) {
  final schemaFileText = printSchema(schema);

  app.get('/graphql-schema', (Request request) {
    return Response.ok(
      schemaFileText,
      headers: {
        HttpHeaders.contentTypeHeader: 'text/plain',
        'content-disposition': downloadSchemaOnOpen
            ? 'attachment; filename="$schemaFilename"'
            : 'inline',
      },
    );
  });

  String printTypeReference(GraphQLType type) => type.whenMaybe(
        list: (type) => '[${printTypeReference(type.ofType)}]',
        nonNullable: (type) => '${printTypeReference(type.ofType)}!',
        orElse: (_) => '<a href="#$type">$type</a>',
      );

  // TODO: there are probably better options
  final schemaWithTypeTags = printSchema(
    schema,
    printer: SchemaPrinter(
      printTypeName: (type) => '<span id="$type">$type</span>',
      printTypeReference: printTypeReference,
    ),
  );

  final _title = appTitle;
  final _description =
      appDescription ?? 'Application implemented with Leto Dart GraphQL';
  const _imageUrl =
      'https://raw.githubusercontent.com/juancastillo0/leto/main/img/leto-logo-white.png';
  const icon =
      'https://github.com/juancastillo0/leto/raw/main/img/leto-icon-transparent.png';

  final schemaFileHtml = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <meta name="description" content="$_description">

  <meta property="og:description" content="$_description">
  <meta property="og:title" content="$_title">
  <meta property="og:url" content="https://github.com/juancastillo0/leto/">
  <meta property="og:image" content="$_imageUrl">

  <meta name="twitter:text:title" content="$_title">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="$_title">
  <meta name="twitter:description" content="$_description">
  <meta name="twitter:image" content="$_imageUrl">

  <!-- iOS meta tags & icons -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="$_title">
  <link rel="apple-touch-icon" href="$icon">

  <!-- Favicon -->
  <link rel="shortcut icon" type="image/png"  href="$icon"/>
  <link rel="apple-touch-icon" sizes="320x320" href="$icon">
  <link rel="icon" type="image/png" href="$icon">

  <title>$_title</title>
<style>
  .disable-select {-webkit-touch-callout: none;-webkit-user-select: none;-khtml-user-select: none;-moz-user-select: none;-ms-user-select: none;user-select: none;}
</style>
</head>
<body style="display: flex;flex-direction: column;padding: 0 6px 16px;">
  <a href="/graphql-schema" class="disable-select" style="padding:12px;">DOWNLOAD</a>
  <pre>$schemaWithTypeTags</pre>
</body>
</html>''';

  app.get('/graphql-schema-interactive', (Request request) {
    return Response.ok(
      schemaFileHtml,
      headers: {HttpHeaders.contentTypeHeader: 'text/html'},
    );
  });
}

void setUpGraphQLExplorers(
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
