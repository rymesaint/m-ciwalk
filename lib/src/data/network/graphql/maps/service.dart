import 'package:ciwalk/src/data/models/location/location.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/network/graphql/client.dart';
import 'package:ciwalk/src/data/network/graphql/maps/schema.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MapService {
  late GraphQLClient _client;

  MapService() {
    GraphQLConfig graphQLConfiguration = GraphQLConfig();
    _client = graphQLConfiguration.getClient();
  }

  Future<Resource<List<Location>>> getLocations() async {
    List<Location> locations = [];

    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getLocationsQuery),
      ),
    );

    if (result.hasException) {
      return Resource(
        data: locations,
        metadata: null,
        error: Error(
          extensions: result.exception?.graphqlErrors[0].extensions,
          message: result.exception?.graphqlErrors[0].message,
        ),
      );
    } else if (result.data != null && !result.isLoading) {
      locations = result.data!["locations"]
          .map<Location>((dynamic item) => Location.fromJson(item))
          .toList();

      return Resource(
        data: locations,
        error: null,
        metadata: null,
      );
    }
    return Resource(data: locations, error: null, metadata: null);
  }

  Future<Resource<Location>> getLocation({String? id}) async {
    Location locationDetail = Location();

    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getLocationQuery),
        variables: {
          "id": id,
        },
      ),
    );

    if (result.hasException) {
      return Resource(
        data: locationDetail,
        metadata: null,
        error: Error(
          extensions: result.exception?.graphqlErrors[0].extensions,
          message: result.exception?.graphqlErrors[0].message,
        ),
      );
    } else if (result.data != null && !result.isLoading) {
      locationDetail = Location.fromJson(result.data!["location"]);

      return Resource(
        data: locationDetail,
        error: null,
        metadata: null,
      );
    }
    return Resource(data: locationDetail, error: null, metadata: null);
  }
}
