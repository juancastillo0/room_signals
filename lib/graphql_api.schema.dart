// ignore: depend_on_referenced_packages
import 'package:leto_schema/leto_schema.dart';
import 'package:room_signals/src/user_api.dart';
import 'package:room_signals/src/room_api.dart';

GraphQLSchema recreateGraphQLApiSchema() {
  HotReloadableDefinition.incrementCounter();
  _graphqlApiSchema = null;
  return graphqlApiSchema;
}

GraphQLSchema? _graphqlApiSchema;
GraphQLSchema get graphqlApiSchema => _graphqlApiSchema ??= GraphQLSchema(
      serdeCtx: SerdeCtx()
        ..addAll([])
        ..children.addAll([]),
      queryType: objectType(
        'Query',
        fields: [
          getUserGraphQLField,
          getListRoomGraphQLField,
        ],
      ),
      mutationType: objectType(
        'Mutation',
        fields: [
          createUserGraphQLField,
          createRoomGraphQLField,
          resetTokenRoomGraphQLField,
          sendMessageRoomGraphQLField,
        ],
      ),
      subscriptionType: objectType(
        'Subscription',
        fields: [
          eventsRoomGraphQLField,
        ],
      ),
    );
