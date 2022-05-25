import 'package:ciwalk/src/data/models/promo/promo.dart';
import 'package:ciwalk/src/data/models/promo_detail/promo_detail.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/network/graphql/client.dart';
import 'package:ciwalk/src/data/network/graphql/promo/schema.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PromoService {
  Future<Resource<List<Promo>>> getPromos({
    int? start,
    int? limit,
    String? query,
    String? type,
    String? sortBy,
  }) async {
    List<Promo> promos = [];

    GraphQLConfig graphQLConfiguration = GraphQLConfig();
    GraphQLClient _client = graphQLConfiguration.getClient();
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getPromosQuery),
        variables: {
          "limit": limit,
          "start": start,
          "type": type,
          "query": query,
          "sortBy": sortBy,
        },
      ),
    );

    if (result.hasException) {
      return Resource(
        data: promos,
        metadata: null,
        error: Error(
          extensions: result.exception?.graphqlErrors[0].extensions,
          message: result.exception?.graphqlErrors[0].message,
        ),
      );
    } else if (result.data != null && !result.isLoading) {
      promos = result.data!["promotionsConnection"]["values"]
          .map<Promo>((dynamic item) => Promo.fromJson(item))
          .toList();

      return Resource(
        data: promos,
        error: null,
        metadata: Metadata(
          count: result.data!["promotionsConnection"]["aggregate"]["count"],
          totalCount: result.data!["promotionsConnection"]["aggregate"]
              ["totalCount"],
        ),
      );
    }
    return Resource(data: promos, error: null, metadata: null);
  }

  Future<Resource<PromoDetail>> getPromoDetails({String? id}) async {
    PromoDetail promoDetail = PromoDetail();

    GraphQLConfig graphQLConfiguration = GraphQLConfig();
    GraphQLClient _client = graphQLConfiguration.getClient();
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getPromoDetailsQuery),
        variables: {
          "id": id,
        },
      ),
    );

    if (result.hasException) {
      return Resource(
        data: promoDetail,
        metadata: null,
        error: Error(
          extensions: result.exception?.graphqlErrors[0].extensions,
          message: result.exception?.graphqlErrors[0].message,
        ),
      );
    } else if (result.data != null && !result.isLoading) {
      promoDetail = PromoDetail.fromJson(result.data!["promotion"]);

      return Resource(
        data: promoDetail,
        error: null,
        metadata: null,
      );
    }
    return Resource(data: promoDetail, error: null, metadata: null);
  }
}
