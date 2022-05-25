import 'package:ciwalk/src/view/homepage/component/event.card.dart';
import 'package:ciwalk/src/view_models/event.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EventsScreen extends GetView<EventViewModel> {
  static const routeName = '/events';
  EventsScreen({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Get.put(EventViewModel());
    return Scaffold(
      appBar: AppBar(
        title: 'Events & Exhibition'.text.make(),
        actions: [
          IconButton(
              onPressed: () => controller.openSearch(context),
              icon: const Icon(Icons.search_rounded)),
          IconButton(
            onPressed: controller.openFilter,
            icon: const Icon(Icons.filter_alt_rounded),
          ),
        ],
      ),
      body: Obx(
        () =>
            controller.isLoading.value && controller.result.value.data!.isEmpty
                ? const CircularProgressIndicator.adaptive().centered()
                : NotificationListener(
                    child: Builder(
                      builder: (context) => GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 250,
                          ),
                          controller: scrollController,
                          itemCount: controller.start <
                                  controller.result.value.metadata!.totalCount!
                                      .toInt()
                              ? controller.result.value.data!.length + 1
                              : controller.result.value.data!.length,
                          itemBuilder: (context, index) {
                            if (index == controller.result.value.data!.length &&
                                controller.start <=
                                    controller
                                        .result.value.metadata!.totalCount!
                                        .toInt()) {
                              return const CircularProgressIndicator.adaptive()
                                  .centered();
                            }

                            final event = controller.result.value.data![index];
                            return EventCard(
                              event: event,
                              onTap: () => controller.openDetail(event),
                            );
                          }),
                    ),
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification &&
                          scrollController.position.pixels >=
                              scrollController.position.maxScrollExtent * 0.8 &&
                          !controller.isLoading.value &&
                          controller.start.value <
                              controller.result.value.metadata!.totalCount!
                                  .toInt()) {
                        controller.loadNextPage();
                      }
                      return true;
                    },
                  ),
      ).p12().safeArea(),
    );
  }
}
