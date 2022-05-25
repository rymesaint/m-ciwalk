import 'package:ciwalk/src/data/models/promo/promo.dart';
import 'package:ciwalk/src/data/models/promo_detail/promo_detail.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/network/graphql/promo/service.dart';

class PromoRepository {
  final PromoService _promoService = PromoService();
  Future<Resource<List<Promo>>> getPromos({
    int? start,
    int? limit,
    String? query,
    String? type,
    String? sortBy = 'createdAt:desc',
  }) async {
    return _promoService.getPromos(
      start: start,
      limit: limit,
      query: query,
      type: type,
      sortBy: sortBy,
    );
  }

  Future<Resource<PromoDetail>> getPromoDetails({
    String? id,
  }) async {
    return _promoService.getPromoDetails(id: id);
  }
}
