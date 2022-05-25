import 'package:ciwalk/src/consts/storage_key.dart';
import 'package:ciwalk/src/data/models/onboarding.dart';
import 'package:ciwalk/src/misc/storage.dart';
import 'package:ciwalk/src/themes/image_path.dart';
import 'package:ciwalk/src/view/about/about_screen.dart';
import 'package:ciwalk/src/view/dashboard/dashboard_screen.dart';
import 'package:ciwalk/src/view_models/base.vm.dart';
import 'package:get/get.dart';

class OnboardingViewModel extends BaseViewModel {
  final pageList = <Onboarding>[
    Onboarding(
        imagePath: LocalImages.explore,
        title: 'Let\'s Explore Time',
        desription:
            'The presence of “Cihampelas Walk” in the midst of the city of Bandung, the mall with a new concept, offering something different from other malls in Indonesia. Different nuances of the mall – the mall the other will be felt starting from the gate we enter Cihampelas Walk down to the inside.'),
  ];

  takeToDashboard() {
    Storage.save(StorageKey.skipOnboarding, true);
    Get.offAllNamed(DashboardScreen.routeName);
  }

  takeAWalk() {
    Get.toNamed(AboutScreen.routeName);
  }
}
