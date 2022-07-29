import 'package:rad/rad.dart';
import 'package:rad/widgets_html.dart';
import 'package:rad/widgets_short_html.dart';

import 'src/flex.dart';
import 'src/provider.dart';
import 'src/room_client_view.dart';
import 'src/theme.dart';

void main() {
  runApp(
    appTargetId: "output",
    app: const Provider(
      value: Theme(
        cardTheme: CardTheme(style: 'width:170px;'),
      ),
      child: Landing(),
    ),
  );
}

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    const _anchorStyle = 'padding-bottom:12px;';

    return const Column(
      cross: AxisAlign.center,
      children: [
        h1(style: 'margin:8px 0;', child: Text('Room Signals')),
        h3(
          style: 'margin:5px 0;',
          child: a(
            href: 'https://github.com/juancastillo0/leto',
            target: '_blank',
            child: Text('Leto GraphQL Dart server example'),
          ),
        ),
        p(
          style: 'max-width:500px;',
          child: Text(
            'A simple web socket enabled GraphQL server'
            ' for managing rooms and message subscriptions.',
          ),
        ),
        Row(
          wrap: FlexWrap.wrap,
          main: AxisAlign.center,
          cross: AxisAlign.stretch,
          children: [
            Card(
              child: Column(
                children: [
                  a(
                    style: _anchorStyle,
                    href: '/graphql-schema',
                    child: Text("Schema"),
                  ),
                  Text(
                    'Download the complete GraphQL server API.',
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  a(
                    style: _anchorStyle,
                    href: '/graphql-schema-interactive',
                    child: Text("Interactive Schema"),
                  ),
                  Text(
                    'View and interact with the GraphQL server API.',
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  a(
                    style: _anchorStyle,
                    href: 'https://github.com/juancastillo0/room_signals',
                    target: '_blank',
                    child: Text("Github Code Repository"),
                  ),
                  Text('The source code of the Dart server and client.'),
                ],
              ),
            ),
          ],
        ),
        h3(
          child: Text('UI Explorers'),
        ),
        p(
          style: 'margin-top:0;max-width:500px;',
          innerText: 'Explore the schema and documentation, and create and execute queries'
              ' with autocompletion using the following tools.',
        ),
        Row(
          wrap: FlexWrap.wrap,
          main: AxisAlign.center,
          cross: AxisAlign.stretch,
          children: [
            Card(
              child: Column(
                children: [
                  a(
                    style: _anchorStyle,
                    href: '/graphql-altair',
                    child: Text("Altair"),
                  ),
                  Image(
                    style: 'padding:7.5px;',
                    height: '35px',
                    width: '35px',
                    src:
                        'https://cdn.jsdelivr.net/npm/altair-static@4.0.9/build/dist/assets/img/logo.svg',
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  a(
                    style: _anchorStyle,
                    href: '/graphql-playground',
                    child: Text("Playground"),
                  ),
                  Image(
                    height: '50px',
                    width: '50px',
                    src:
                        'https://cdn.jsdelivr.net/npm/graphql-playground-react/build/favicon.png',
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  a(
                    style: _anchorStyle,
                    href: '/graphql-graphiql',
                    child: span(
                      children: [
                        Text('GraphiQL'),
                        // em(innerText: 'i'),
                        // Text('QL'),
                      ],
                    ),
                  ),
                  Text('The classic GraphQL explorer.'),
                ],
              ),
            ),
          ],
        ),
        h3(
          child: Text('Try the Client'),
        ),
        RoomSignalsClientView(),
      ],
    );
  }
}
