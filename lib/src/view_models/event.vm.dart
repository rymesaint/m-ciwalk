import 'package:ciwalk/src/data/models/event/event.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/repositories/event.dart';
import 'package:ciwalk/src/view/events/component/event_filter.dart';
import 'package:ciwalk/src/view/events/component/event_search.dart';
import 'package:ciwalk/src/view/events/event_detail_screen.dart';
import 'package:ciwalk/src/view_models/base.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventViewModel extends BaseViewModel {
  final isLoading = false.obs;
  final int limit = 12;
  final start = 0.obs;
  final sortBy = 'desc'.obs;
  final type = ''.obs;
  final result = Resource<List<Event>>(
    data: [],
    error: null,
    metadata: null,
  ).obs;

  @override
  void onInit() {
    fetchEvents(page: 0);
    super.onInit();
  }

  fetchEvents({int? page}) async {
    isLoading(true);
    var response = await EventRepository().getEvents(
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
    fetchEvents(page: start.value);
  }

  openFilter() {
    Get.bottomSheet(EventFilter(vm: this),
        isScrollControlled: true, isDismissible: true);
  }

  changeSortBy(String? sort) {
    if (sort != null) {
      start.value = 0;
      sortBy.value = sort;
      result.value.data?.clear();
      fetchEvents(page: start.value);
    }
  }

  changeType(String? typeSelected) {
    if (typeSelected != null) {
      start.value = 0;
      type.value = typeSelected;
      result.value.data?.clear();
      fetchEvents(page: start.value);
    }
  }

  openSearch(BuildContext context) {
    showSearch(context: context, delegate: EventSearchDelegate());
  }

  openDetail(Event event) async {
    Get.toNamed(EventDetailScreen.routeName, arguments: event);
  }
}
