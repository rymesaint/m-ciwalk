import 'package:ciwalk/src/consts/storage_key.dart';
import 'package:ciwalk/src/misc/storage.dart';
import 'package:ciwalk/src/routes.dart';
import 'package:ciwalk/src/themes/theme.dart';
import 'package:ciwalk/src/view/dashboard/dashboard_screen.dart';
import 'package:ciwalk/src/view/onboarding/onboarding_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  App({Key? key}) : super(key: key);

  String get initialRoute {
    if (Storage.hasData(StorageKey.skipOnboarding)) {
      if (Storage.get(StorageKey.skipOnboarding) == true) {
        return DashboardScreen.routeName;
      }
      return OnboardingScreen.routeName;
    } else {
      return OnboardingScreen.routeName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'mCiwalk',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      themeMode: ThemeMode.light,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      initialRoute: initialRoute,
      getPages: routes,
      navigatorKey: Get.key,
      builder: EasyLoading.init(),
    );
  }
}
