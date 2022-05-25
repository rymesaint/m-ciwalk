import 'package:ciwalk/src/view/homepage/component/promo.card.dart';
import 'package:ciwalk/src/view_models/promo.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PromoScreen extends GetView<PromoViewModel> {
  static const routeName = '/promos';
  PromoScreen({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Get.put(PromoViewModel());
    return Scaffold(
      appBar: AppBar(
        title: 'Special Offers'.text.make(),
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

                            final promo = controller.result.value.data![index];
                            return PromoCard(
                              promo: promo,
                              onTap: () => controller.openDetail(promo),
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
