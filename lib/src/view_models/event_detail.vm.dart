import 'package:ciwalk/src/data/models/event_detail/event_detail.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/repositories/event.dart';
import 'package:ciwalk/src/view_models/base.vm.dart';
import 'package:get/get.dart';

class EventDetailViewModel extends BaseViewModel {
  final isLoading = false.obs;
  final result = Resource<EventDetail>(
    data: EventDetail(),
  ).obs;

  EventDetailViewModel() {
    result.value.data?.id = Get.arguments.id;
  }

  @override
  void onInit() {
    fetchEvent();
    super.onInit();
  }

  fetchEvent() async {
    isLoading(true);
    var response = await EventRepository().getEventDetails(
      id: result.value.data?.id,
    );
    isLoading(false);

    result.value.data = response.data;
  }
}
