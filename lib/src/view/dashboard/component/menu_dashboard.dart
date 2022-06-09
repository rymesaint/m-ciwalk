import 'package:ciwalk/src/misc/ui.spacer.dart';
import 'package:ciwalk/src/view_models/dashboard.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MenuDashboard extends GetView<DashboardViewModel> {
  const MenuDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        Image.asset('assets/images/leaf_left.png'),
        "m-Ciwalk".text.xl4.make(),
        ListTile(
          onTap: controller.openMenu,
          leading: const Icon(
            Icons.home,
            size: 20.0,
          ),
          title: 'Home'.text.make(),
          dense: true,
        ),
        ListTile(
          onTap: controller.openAbout,
          leading: const Icon(
            Icons.info_outlined,
            size: 20.0,
          ),
          title: 'About'.text.make(),
          dense: true,
        ),
        ListTile(
          onTap: controller.openContact,
          leading: const Icon(
            Icons.open_in_new_rounded,
            size: 20.0,
          ),
          title: 'Contact'.text.make(),
          dense: true,
        ),
        UiSpacer.divider(),
        ListTile(
          onTap: () {},
          leading: const Icon(
            Icons.perm_device_info_rounded,
            size: 20.0,
          ),
          title: 'App Info'.text.make(),
          dense: true,
        ),
      ],
      alignment: MainAxisAlignment.center,
      crossAlignment: CrossAxisAlignment.start,
    ).scrollVertical();
  }
}
