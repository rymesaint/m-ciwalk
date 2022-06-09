import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/models/tenant/tag.dart';
import 'package:ciwalk/src/data/models/tenant/tenant.dart';
import 'package:ciwalk/src/repositories/tag.dart';
import 'package:ciwalk/src/view/tenant/tenant_detail_screen.dart';
import 'package:ciwalk/src/view_models/base.vm.dart';
import 'package:get/get.dart';

class TagsViewModel extends BaseViewModel {
  final isLoading = false.obs;
  final int limit = 12;
  final start = 0.obs;
  final sortBy = 'desc'.obs;
  final tag = Tag().obs;
  final result = Resource<List<Tenant>>(
    data: [],
    error: null,
    metadata: Metadata(totalCount: 0),
  ).obs;

  TagsViewModel() {
    tag(Get.arguments);
  }

  @override
  void onInit() {
    _fetchTenants(page: 0);
    super.onInit();
  }

  _fetchTenants({int? page}) async {
    isLoading(true);
    var response = await TagRepository().getTenants(
      slug: tag.value.slug,
      type: tag.value.type,
      page: page,
    );
    isLoading(false);
    result.update((val) {
      val?.error = response.error;
      val?.metadata = response.metadata;
      val?.data?.addAll(response.data!.map((e) => e));
    });
  }

  void loadNextPage() {
    start(start.value + 12);
    _fetchTenants(page: start.value);
  }

  // openFilter() {
  //   Get.bottomSheet(PromoFilter(vm: this),
  //       isScrollControlled: true, isDismissible: true);
  // }

  changeSortBy(String? sort) {
    if (sort != null) {
      start.value = 0;
      sortBy.value = sort;
      result.value.data?.clear();
      _fetchTenants(page: start.value);
    }
  }

  openTenant(Tenant tenant) {
    Get.toNamed(TenantDetailScreen.routeName, arguments: tenant);
  }

  // openSearch(BuildContext context) {
  //   showSearch(context: context, delegate: PromoSearchDelegate());
  // }

  // openDetail(Promo promo) async {
  //   Get.toNamed(PromoDetailScreen.routeName, arguments: promo);
  // }
}
