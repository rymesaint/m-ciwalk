import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/models/tenant/tenant.dart';
import 'package:ciwalk/src/data/network/graphql/client.dart';
import 'package:ciwalk/src/data/network/graphql/tenants/schema.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TenantService {
  late GraphQLClient _client;

  TenantService() {
    GraphQLConfig graphQLConfiguration = GraphQLConfig();
    _client = graphQLConfiguration.getClient();
  }

  Future<Resource<List<Tenant>>> getTenants({String? locationId}) async {
    List<Tenant> tenants = [];

    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getTenantsQuery),
        variables: {
          "where": {
            "locations": {
              "_id": locationId,
            },
            "tags": const {
              "slug_contains": null,
            }
          }
        },
      ),
    );

    if (result.hasException) {
      return Resource(
        data: tenants,
        metadata: null,
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
        metadata: null,
      );
    }
    return Resource(data: tenants, error: null, metadata: null);
  }

  Future<Resource<Tenant>> getTenantDetail({String? id}) async {
    Tenant? tenant;

    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getTenantDetailQuery),
        variables: {
          "id": id,
        },
      ),
    );

    if (result.hasException) {
      return Resource(
        data: tenant,
        metadata: null,
        error: Error(
          extensions: result.exception?.graphqlErrors[0].extensions,
          message: result.exception?.graphqlErrors[0].message,
        ),
      );
    } else if (result.data != null && !result.isLoading) {
      tenant = Tenant.fromJson(result.data!["tenant"]);

      return Resource(
        data: tenant,
        error: null,
        metadata: null,
      );
    }
    return Resource(data: tenant, error: null, metadata: null);
  }

  Future<Resource<List<Tenant>>> getRelatedTenants(
      {String? currentTenantId, String? type}) async {
    List<Tenant> tenants = [];

    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(relatedTenantsQuery),
        variables: {
          "where": {
            "name_contains": null,
            "locations": const {"name_contains": null},
            "tags": const {"slug_contains": null},
            "_id_ne": currentTenantId,
            "type_contains": type,
          }
        },
      ),
    );

    if (result.hasException) {
      return Resource(
        data: tenants,
        metadata: null,
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
          count: result.data!["tenantsConnection"]["aggregate"]["count"],
          totalCount: result.data!["tenantsConnection"]["aggregate"]
              ["totalCount"],
        ),
      );
    }
    return Resource(data: tenants, error: null, metadata: null);
  }
}
