import 'package:cached_network_image/cached_network_image.dart';
import 'package:ciwalk/src/misc/ui.spacer.dart';
import 'package:ciwalk/src/themes/colors.dart';
import 'package:ciwalk/src/view_models/tenant.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class TenantDetailScreen extends GetView<TenantViewModel> {
  static const routeName = '/tenant/detail';
  const TenantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TenantViewModel());
    return Scaffold(
      appBar: AppBar(
        title: (controller.tenant.value.name ?? '-').text.make(),
        actions: [
          Obx(
            () => controller.tenant.value.link == null
                ? UiSpacer.emptySpace()
                : IconButton(
                    onPressed: controller.openLink,
                    icon: const Icon(Icons.open_in_new_rounded)),
          ),
        ],
      ),
      body: Obx(
        () => VStack([
          controller.tenant.value.thumbnail?.url == null
              ? 'No Image'
                  .text
                  .makeCentered()
                  .box
                  .gray500
                  .make()
                  .h(180)
                  .wFull(context)
              : CachedNetworkImage(
                  imageUrl: controller.tenant.value.thumbnail!.url!,
                  fit: BoxFit.contain,
                ).centered().h(180),
          UiSpacer.verticalSpace(),
          HStack(
            [
              VStack([
                'Open Hours'.text.semiBold.make(),
                '${controller.tenant.value.opened} - ${controller.tenant.value.closed} WIB'
                    .text
                    .make(),
              ]),
              VStack([
                'Contact'.text.semiBold.make(),
                (controller.tenant.value.contact ?? '-').text.make(),
              ]),
              VStack(
                [
                  'Location'.text.semiBold.make(),
                  Icon(
                    Icons.place_rounded,
                    color: primaryColor,
                  ),
                ],
                alignment: MainAxisAlignment.center,
                crossAlignment: CrossAxisAlignment.center,
              ).onInkTap(controller.openTenantLocations),
            ],
            alignment: MainAxisAlignment.spaceAround,
            axisSize: MainAxisSize.max,
          ),
          UiSpacer.verticalSpace(),
          'Description'.text.semiBold.lg.make(),
          (controller.tenant.value.body ?? '-').text.make(),
          UiSpacer.verticalSpace(),
          'Gallery'.text.semiBold.lg.make(),
          UiSpacer.verticalSpace(space: 10),
          controller.tenant.value.gallery == null
              ? 'There are no photo gallery.'.text.make()
              : ListView.builder(
                  itemBuilder: (context, index) {
                    final gallery = controller.tenant.value.gallery?[index];
                    if (gallery?.url == null) {
                      return UiSpacer.emptySpace();
                    }
                    return CachedNetworkImage(
                      imageUrl: gallery!.url!,
                      fit: BoxFit.cover,
                    ).w(140).cornerRadius(20).px(4);
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.tenant.value.gallery?.length,
                ).h(140),
          UiSpacer.verticalSpace(),
          'Tags'.text.semiBold.lg.make(),
          UiSpacer.verticalSpace(space: 10),
          controller.tenant.value.tags == null
              ? 'There are no tags.'.text.makeCentered()
              : ListView.builder(
                  itemBuilder: (context, index) {
                    final tag = controller.tenant.value.tags?[index];
                    return (tag?.name ?? '-').text.make().px(4);
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.tenant.value.tags?.length,
                ).h(140),
          'Related ${controller.tenantType.value}'.text.semiBold.lg.make(),
          UiSpacer.verticalSpace(space: 10),
          controller.relatedTenants.value.data == null
              ? 'There are no related tenants.'.text.make()
              : ListView.builder(
                  itemBuilder: (context, index) {
                    final tenant = controller.relatedTenants.value.data?[index];
                    return VStack([
                      CachedNetworkImage(
                        imageUrl: tenant!.thumbnail!.url!,
                        fit: BoxFit.contain,
                      ).h(140).cornerRadius(20),
                      UiSpacer.verticalSpace(space: 5),
                      (tenant.name ?? '-').text.ellipsis.make(),
                    ])
                        .w(140)
                        .px(10)
                        .onInkTap(() => controller.openTenant(tenant));
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.relatedTenants.value.data?.length,
                ).h(165),
        ]).p12().safeArea().scrollVertical(),
      ),
    );
  }
}
