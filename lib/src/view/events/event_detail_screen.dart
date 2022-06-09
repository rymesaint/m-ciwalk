import 'package:cached_network_image/cached_network_image.dart';
import 'package:ciwalk/src/misc/ui.spacer.dart';
import 'package:ciwalk/src/view_models/event_detail.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EventDetailScreen extends GetView<EventDetailViewModel> {
  static const routeName = '/events/detail';
  const EventDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(EventDetailViewModel());
    return Scaffold(
        body: Obx(
      () => controller.isLoading.value &&
              controller.result.value.data?.slug == null
          ? const CircularProgressIndicator.adaptive().centered()
          : NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: CachedNetworkImage(
                      imageUrl: controller.result.value.data!.thumbnail!.imageUrl
                          .toString(),
                      fit: BoxFit.fill,
                    ).cornerRadius(20),
                  ),
                  expandedHeight: 250,
                )
              ],
              body: VStack([
                HStack([
                  (controller.result.value.data?.title ?? '-')
                      .text
                      .xl
                      .semiBold
                      .make()
                      .expand(),
                  (controller.result.value.data?.statusEvent == 'Finished'
                          ? 'Finished'
                          : '')
                      .text
                      .color(controller.result.value.data?.statusEvent ==
                              'Finished'
                          ? Colors.white
                          : Colors.transparent)
                      .make()
                      .box
                      .p4
                      .roundedSM
                      .color(controller.result.value.data?.statusEvent ==
                              'Finished'
                          ? Colors.green
                          : Colors.transparent)
                      .make()
                ]),
                UiSpacer.verticalSpace(space: 10),
                HStack(
                  [
                    VStack([
                      'From'.text.semiBold.make(),
                      (controller.result.value.data?.startedFormat ?? '-')
                          .text
                          .make(),
                    ]).expand(),
                    VStack([
                      'To'.text.semiBold.make(),
                      (controller.result.value.data?.endedFormat ?? '-')
                          .text
                          .make(),
                    ]),
                  ],
                  alignment: MainAxisAlignment.start,
                  crossAlignment: CrossAxisAlignment.start,
                  axisSize: MainAxisSize.max,
                ),
                UiSpacer.verticalSpace(),
                (controller.result.value.data?.body ?? '-').text.make(),
              ]).p12().scrollVertical(),
            ),
    ));
  }
}
