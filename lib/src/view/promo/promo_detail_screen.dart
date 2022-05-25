import 'package:cached_network_image/cached_network_image.dart';
import 'package:ciwalk/src/misc/ui.spacer.dart';
import 'package:ciwalk/src/view_models/promo_detail.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PromoDetailScreen extends GetView<PromoDetailViewModel> {
  static const routeName = '/promos/detail';
  const PromoDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PromoDetailViewModel());
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
                      imageUrl: controller.result.value.data!.thumbnail!.url
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
                  (controller.result.value.data?.statusPromo == 'Finished'
                          ? 'Finished'
                          : '')
                      .text
                      .color(controller.result.value.data?.statusPromo ==
                              'Finished'
                          ? Colors.white
                          : Colors.transparent)
                      .make()
                      .box
                      .p4
                      .roundedSM
                      .color(controller.result.value.data?.statusPromo ==
                              'Finished'
                          ? Colors.green
                          : Colors.transparent)
                      .make()
                ]),
                UiSpacer.verticalSpace(space: 10),
                VStack(
                  [
                    'Tenant'.text.semiBold.make(),
                    (controller.result.value.data?.tenant?.name ?? '-')
                        .text
                        .make(),
                  ],
                ),
                UiSpacer.verticalSpace(space: 10),
                HStack(
                  [
                    VStack([
                      'From'.text.semiBold.make(),
                      (controller.result.value.data?.startedFormat ?? '-')
                          .text
                          .make(),
                    ]),
                    UiSpacer.horizontalSpace(),
                    VStack([
                      'To'.text.semiBold.make(),
                      (controller.result.value.data?.endedFormat ?? '-')
                          .text
                          .make(),
                    ]),
                  ],
                  alignment: MainAxisAlignment.spaceBetween,
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
