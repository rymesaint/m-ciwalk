import 'package:ciwalk/src/data/models/location/location.dart';
import 'package:ciwalk/src/misc/ui.spacer.dart';
import 'package:ciwalk/src/themes/colors.dart';
import 'package:ciwalk/src/view_models/map.vm.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MapScreen extends GetView<MapViewModel> {
  static const routeName = '/maps';
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MapViewModel());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: 'Floor Map'.text.make(),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            collapsedHeight: 332,
            pinned: true,
            elevation: 0,
            primary: true,
            floating: true,
            flexibleSpace: Obx(
              () => VStack([
                controller.locations.value.data!.isEmpty
                    ? 'Tidak ada lokasi terdaftar'.text.makeCentered()
                    : DropdownButtonFormField(
                        items: controller.locations.value.data!
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: (e.name ?? '-').text.make(),
                                ))
                            .toList(),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor)),
                          hintText: 'Please select a location',
                        ),
                        onChanged: (Location? location) =>
                            controller.selectLocation(location)),
                controller.selectedLocation.value.map == null
                    ? UiSpacer.emptySpace()
                    : controller.selectedLocation.value.map?.url == null
                        ? 'Image source not found'.text.makeCentered()
                        : ExtendedImage.network(
                            controller.selectedLocation.value.map!.url!,
                            enableLoadState: true,
                            cache: true,
                            handleLoadingProgress: true,
                            retries: 3,
                            mode: ExtendedImageMode.gesture,
                            initGestureConfigHandler: (state) {
                              return GestureConfig(
                                minScale: 0.9,
                                animationMinScale: 0.7,
                                maxScale: 3.0,
                                animationMaxScale: 3.5,
                                speed: 1.0,
                                inertialSpeed: 100.0,
                                initialScale: 1.0,
                                inPageView: false,
                                initialAlignment: InitialAlignment.center,
                              );
                            },
                          ),
              ]).p12(),
            ),
          )
        ],
        body: Obx(
          () => ListView.builder(
            itemCount: controller.tenants.value.data?.length,
            itemBuilder: (context, index) {
              final tenant = controller.tenants.value.data?[index];
              return ListTile(
                leading: (tenant?.coordinate ?? '').text.make(),
                title: (tenant?.name ?? '-').text.make(),
                subtitle: (tenant?.type ?? '-').text.make(),
                onTap: () => controller.openTenant(tenant),
              );
            },
          ),
        ).safeArea(),
      ),
    );
  }
}
