import 'package:ciwalk/src/misc/browser.dart';
import 'package:ciwalk/src/view/about/about_screen.dart';
import 'package:ciwalk/src/view_models/base.vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class DashboardViewModel extends BaseViewModel {
  static DashboardViewModel get to => DashboardViewModel();
  final indexPage = 0.obs;
  final page = PageController();
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();

  changePage(int index) {
    indexPage(index);
    page.jumpToPage(index);
  }

  openAbout() {
    Get.toNamed(AboutScreen.routeName);
  }

  openContact() async {
    ChromeSafariBrowser myBrowser = MyBrowser();
    await myBrowser.open(
        url: Uri.tryParse('https://ciwalk.com/contact?ref=menu')!);
  }

  openMenu() {
    final state = sideMenuKey.currentState;
    if (state!.isOpened) {
      state.closeSideMenu(); // close side menu
    } else {
      state.openSideMenu(); // open side menu
    }
  }
}
