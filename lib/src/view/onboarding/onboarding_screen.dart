import 'package:ciwalk/src/misc/ui.spacer.dart';
import 'package:ciwalk/src/themes/colors.dart';
import 'package:ciwalk/src/view_models/onboarding.vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:onboarding/onboarding.dart';
import 'package:velocity_x/velocity_x.dart';

class OnboardingScreen extends GetView<OnboardingViewModel> {
  static const routeName = '/onboard';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingViewModel());
    return Scaffold(
      body: Onboarding(
        pages: controller.pageList
            .map(
              (page) => PageModel(
                widget: VStack(
                  [
                    SvgPicture.asset(page.imagePath).h(350),
                    page.title.text.xl3.semiBold.makeCentered(),
                    UiSpacer.verticalSpace(),
                    (page.desription ?? '-').text.makeCentered(),
                    UiSpacer.verticalSpace(space: 40),
                    'Let\'s Take a Walk'
                        .text
                        .color(primaryColor)
                        .makeCentered()
                        .continuousRectangle(
                          height: 40,
                          backgroundColor: Colors.transparent,
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        )
                        .onInkTap(controller.takeAWalk),
                    UiSpacer.verticalSpace(),
                    'Lewati ke Beranda'
                        .text
                        .gray500
                        .makeCentered()
                        .onTap(controller.takeToDashboard),
                  ],
                ),
              ),
            )
            .toList(),
        startPageIndex: 0,
      ).p12(),
    );
  }
}
