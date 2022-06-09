import 'package:ciwalk/src/view/tags/component/tenant.card.dart';
import 'package:ciwalk/src/view_models/tags.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class TagsScreen extends GetView<TagsViewModel> {
  static const routeName = '/tags/tenants';
  TagsScreen({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Get.put(TagsViewModel());
    return Scaffold(
      appBar: AppBar(
        title: (controller.tag.value.name ?? '-').text.make(),
        actions: const [
          // IconButton(
          //     onPressed: () => controller.openSearch(context),
          //     icon: const Icon(Icons.search_rounded)),
          // IconButton(
          //   onPressed: controller.openFilter,
          //   icon: const Icon(Icons.filter_alt_rounded),
          // ),
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

                            final tenant = controller.result.value.data![index];
                            return TenantCard(
                              tenant: tenant,
                              onTap: () => controller.openTenant(tenant),
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
