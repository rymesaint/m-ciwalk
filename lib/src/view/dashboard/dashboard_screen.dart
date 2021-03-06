import 'package:ciwalk/src/view/dashboard/component/menu_dashboard.dart';
import 'package:ciwalk/src/view/events/events_screen.dart';
import 'package:ciwalk/src/view/homepage/homepage_screen.dart';
import 'package:ciwalk/src/view/movies/movies_screen.dart';
import 'package:ciwalk/src/view/promo/promo_screen.dart';
import 'package:ciwalk/src/view_models/dashboard.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class DashboardScreen extends GetView<DashboardViewModel> {
  static const routeName = '/dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardViewModel());
    return Obx(
      () => SideMenu(
        key: controller.sideMenuKey,
        background: const Color(0xfff8f9fa),
        closeIcon: const Icon(Icons.close),
        menu: const MenuDashboard().paddingOnly(left: 25),
        type: SideMenuType.shrikNRotate,
        child: Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.page,
            children: [
              const HomepageScreen(),
              EventsScreen(),
              PromoScreen(),
              MoviesScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.indexPage.value,
            onTap: controller.changePage,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.event,
                ),
                label: 'Events',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.percent_rounded,
                ),
                label: 'Promotions',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.movie_rounded,
                ),
                label: 'Movies',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
