import 'package:ciwalk/src/data/models/promo_detail/promo_detail.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/repositories/promo.dart';
import 'package:ciwalk/src/view_models/base.vm.dart';
import 'package:get/get.dart';

class PromoDetailViewModel extends BaseViewModel {
  final isLoading = false.obs;
  final result = Resource<PromoDetail>(
    data: PromoDetail(),
  ).obs;

  PromoDetailViewModel() {
    result.value.data?.id = Get.arguments.id;
  }

  @override
  void onInit() {
    fetchPromo();
    super.onInit();
  }

  fetchPromo() async {
    isLoading(true);
    var response = await PromoRepository().getPromoDetails(
      id: result.value.data?.id,
    );
    isLoading(false);

    result.value.data = response.data;
  }
}
