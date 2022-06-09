import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/models/tenant/tag.dart';
import 'package:ciwalk/src/data/models/tenant/tenant.dart';
import 'package:ciwalk/src/data/network/graphql/client.dart';
import 'package:ciwalk/src/data/network/graphql/tags/schema.dart';
import 'package:ciwalk/src/data/network/graphql/tenants/schema.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TagService {
  late GraphQLClient _client;

  TagService() {
    GraphQLConfig graphQLConfiguration = GraphQLConfig();
    _client = graphQLConfiguration.getClient();
  }

  Future<Resource<List<Tag>>> getTags({
    int? start,
    int? limit,
    String? type,
    String? sortBy,
  }) async {
    List<Tag> tags = [];

    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getTagsQuery),
        variables: {
          "where": {
            "type": type,
          }
        },
      ),
    );

    if (result.hasException) {
      return Resource(
        data: tags,
        metadata: null,
        error: Error(
          extensions: result.exception?.graphqlErrors[0].extensions,
          message: result.exception?.graphqlErrors[0].message,
        ),
      );
    } else if (result.data != null && !result.isLoading) {
      tags = result.data!["tags"]
          .map<Tag>((dynamic item) => Tag.fromJson(item))
          .toList();

      return Resource(
        data: tags,
        error: null,
        metadata: null,
      );
    }
    return Resource(data: tags, error: null, metadata: null);
  }

  Future<Resource<List<Tenant>>> getTenants(
      {String? slug, String? type, int? page}) async {
    List<Tenant> tenants = [];

    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getTenantsQuery),
        variables: {
          "where": {
            "name_contains": null,
            "locations": const {"name_contains": null},
            "tags": {
              "slug_contains": [slug]
            },
            "_id_ne": null,
            "type_contains": type
          },
          "start": page,
        },
      ),
    );

    if (result.hasException) {
      return Resource(
        data: tenants,
        metadata: Metadata(totalCount: 0),
        error: Error(
          extensions: result.exception?.graphqlErrors[0].extensions,
          message: result.exception?.graphqlErrors[0].message,
        ),
      );
    } else if (result.data != null && !result.isLoading) {
      tenants = result.data!["tenantsConnection"]["values"]
          .map<Tenant>((dynamic item) => Tenant.fromJson(item))
          .toList();

      return Resource(
        data: tenants,
        error: null,
        metadata: Metadata(
          count: result.data!['tenantsConnection']['aggregate']['count'],
          totalCount: result.data!['tenantsConnection']['aggregate']
              ['totalCount'],
        ),
      );
    }
    return Resource(
        data: tenants, error: null, metadata: Metadata(totalCount: 0));
  }
}
