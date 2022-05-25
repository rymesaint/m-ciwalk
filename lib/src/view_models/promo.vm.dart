import 'package:ciwalk/src/data/models/promo/promo.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/repositories/promo.dart';
import 'package:ciwalk/src/view/promo/component/promo_filter.dart';
import 'package:ciwalk/src/view/promo/component/promo_search.dart';
import 'package:ciwalk/src/view/promo/promo_detail_screen.dart';
import 'package:ciwalk/src/view_models/base.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromoViewModel extends BaseViewModel {
  final isLoading = false.obs;
  final int limit = 12;
  final start = 0.obs;
  final sortBy = 'desc'.obs;
  final type = ''.obs;
  final result = Resource<List<Promo>>(
    data: [],
    error: null,
    metadata: null,
  ).obs;

  @override
  void onInit() {
    fetchPromos(page: 0);
    super.onInit();
  }

  fetchPromos({int? page}) async {
    isLoading(true);
    var response = await PromoRepository().getPromos(
      start: page,
      limit: limit,
      sortBy: 'createdAt:${sortBy.value}',
      type: type.value == '' ? null : type.value,
    );
    isLoading(false);
    result.value.error = response.error;
    result.value.metadata = response.metadata;
    result.value.data?.addAll(response.data!.map((e) => e));
  }

  void loadNextPage() {
    start.value += 12;
    fetchPromos(page: start.value);
  }

  openFilter() {
    Get.bottomSheet(PromoFilter(vm: this),
        isScrollControlled: true, isDismissible: true);
  }

  changeSortBy(String? sort) {
    if (sort != null) {
      start.value = 0;
      sortBy.value = sort;
      result.value.data?.clear();
      fetchPromos(page: start.value);
    }
  }

  changeType(String? typeSelected) {
    if (typeSelected != null) {
      start.value = 0;
      type.value = typeSelected;
      result.value.data?.clear();
      fetchPromos(page: start.value);
    }
  }

  openSearch(BuildContext context) {
    showSearch(context: context, delegate: PromoSearchDelegate());
  }

  openDetail(Promo promo) async {
    Get.toNamed(PromoDetailScreen.routeName, arguments: promo);
  }
}
