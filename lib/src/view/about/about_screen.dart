import 'package:cached_network_image/cached_network_image.dart';
import 'package:ciwalk/src/misc/ui.spacer.dart';
import 'package:ciwalk/src/view_models/about.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AboutScreen extends GetView<AboutViewModel> {
  static const routeName = '/about';
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AboutViewModel());
    return Scaffold(
      appBar: AppBar(
        title: 'Mall Profile'.text.make(),
        actions: [
          IconButton(
              onPressed: controller.shareAbout, icon: const Icon(Icons.share)),
        ],
      ),
      body: VStack([
        'The Origin'.text.semiBold.xl3.makeCentered(),
        'A brief of history, it’s all begin here'.text.semiBold.makeCentered(),
        UiSpacer.verticalSpace(),
        'The presence of “Cihampelas Walk” in the midst of the city of Bandung, the mall with a new concept, offering something different from other malls in Indonesia. Different nuances of the mall – the mall the other will be felt starting from the gate we enter Cihampelas Walk down to the inside. Cihampelas Walk is a shopping center with a different atmosphere, because the mall was founded in the middle of an open area (open water), so that is a blend of modern shopping building with a beautiful natural atmosphere and refreshing. Cihampelas Walk was established on an area of approximately 3.5 hectares, with a contour somewhat rugged. From an area about it, only one third of the total area used for building shops, while 2 / 3 others or most of the area used for parking lots and the rest are left overgrown with trees either already tens of years old, and some new plants we added to complement and make the atmosphere inside the mall like a different city.'
            .text
            .center
            .make(),
        UiSpacer.verticalSpace(),
        'Cihampelas Walk in the fashion shopping area (exact center of the store jeans) Cihampelas streets of Bandung which has long been renowned as a tourist destination both locally and overseas. From Cihampelas Walk, frenzied atmosphere that blend Cihampelas road between rows of shops and vehicle congestion, will not be felt. In different areas, beautiful and clean these visitors will be more convenient to shop.'
            .text
            .center
            .make(),
        ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            CachedNetworkImage(
                    imageUrl:
                        'https://res.cloudinary.com/df2knrwm3/image/upload/w_500,c_scale/Photo%20Stock/Architecture/Ciwalk_Mall_Bandung_Architecture_11_ayi9sa.jpg')
                .w(180)
                .p4(),
            CachedNetworkImage(
                    imageUrl:
                        'https://res.cloudinary.com/df2knrwm3/image/upload/w_500,c_scale/Photo%20Stock/Architecture/Ciwalk_Mall_Bandung_Architecture_7_reuade.jpg')
                .w(180)
                .p4(),
            CachedNetworkImage(
                    imageUrl:
                        'https://res.cloudinary.com/df2knrwm3/image/upload/w_500,c_scale/Photo%20Stock/Architecture/Ciwalk_Mall_Bandung_Architecture_zcpijq')
                .w(180)
                .p4(),
          ],
        ).h(200),
        UiSpacer.verticalSpace(),
        'The Architecture Designing Buildings with Unique Value'
            .text
            .semiBold
            .xl
            .make(),
        UiSpacer.verticalSpace(),
        'CiWalk or Ciwalk Cihampelas has been transformed not only as places to shop (retail) or a place to eat (restaurants and food court), but also as a place convenient Entertainment. Freshness of the air and the beautiful atmosphere and supported by the neat layout has made Cihampelas Walk crowded visitors both from local or from outside Bandung. As one of the icons of tourism, Cihampelas Walk also helps to make the city of Bandung as the City Tourism.'
            .text
            .center
            .make(),
        UiSpacer.verticalSpace(),
        'As a tourist, Cihampelas Walk was established by merging three-storey mall building is equipped with other buildings around it, connected by pedestrian areas for pedestrians and also the beautiful gardens and interesting. Building a mall that opened since the 11th of June 2004, has a modern style. This can be seen from the physical building with a game nan bright colors. In addition to the three- story main building malls, in Cihampelas Walk there are also building co-located on the left and right of the main building which is divided into two areas, the right area or better known as Young Street consists of stores and shops for young children, while areas left or the kebih known more Broadway leads to a more adult. The building blocks include 150 shops, which consists of fashion, cafes, restaurants, foodcourt, cinema, games and playground.'
            .text
            .center
            .make(),
        UiSpacer.verticalSpace(),
        CachedNetworkImage(
            imageUrl:
                'https://res.cloudinary.com/df2knrwm3/image/upload/w_800,c_scale/Photo%20Stock/Moments/Ciwalk_Mall_Bandung_Closeup_Moments35_drpgi7.jpg'),
        UiSpacer.verticalSpace(),
        'A little morphine in all the air. It would be wonderfully'
            .text
            .xl
            .semiBold
            .make(),
        UiSpacer.verticalSpace(),
        'Take a stroll in Cihampelas Walk at noon, afternoon and evening will feel different atmosphere. Lights from each booth and the main building at night to build a different atmosphere. Parking area itself is located in the basement of the building and the lower right side of the outer area, so the pacing of vehicles visitors will not bother the visitors who were walking or relaxing in the area shopping and dining.'
            .text
            .center
            .make(),
        'Under these conditions, Cihampelas Walk not merely be a shopping center but it can also become tourist attractions. As a supporter, Cihampelas Walk is also equipped with ample parking that can accommodate approximately 800 vehicles. For the tourists, also provided special parking area for tourist buses that can accommodate approximately 8 units bus.'
            .text
            .center
            .make(),
      ]).p12().safeArea().scrollVertical(),
    );
  }
}
