import 'package:ciwalk/src/consts/config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(Config.baseUrl);

  GraphQLClient getClient() {
    return GraphQLClient(
      cache: GraphQLCache(
        store: HiveStore(),
      ),
      link: httpLink,
    );
  }
}
