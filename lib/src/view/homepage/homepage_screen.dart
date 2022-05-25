import 'package:ciwalk/src/themes/colors.dart';
import 'package:ciwalk/src/view/homepage/component/event.card.dart';
import 'package:ciwalk/src/view/homepage/component/movie.card.dart';
import 'package:ciwalk/src/view/homepage/component/promo.card.dart';
import 'package:ciwalk/src/view_models/homepage.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HomepageScreen extends GetView<HomepageViewModel> {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomepageViewModel());
    return Scaffold(
      body: VStack([
        HStack([
          'm-Ciwalk'.text.semiBold.xl3.make().expand(),
          IconButton(
            onPressed: null,
            icon: const Icon(Icons.map_rounded),
            color: primaryColor,
          ),
          IconButton(
            onPressed: controller.openAbout,
            icon: const Icon(Icons.info_rounded),
            color: primaryColor,
          ),
        ]),
        HStack([
          'What\'s On'.text.xl.semiBold.make().expand(),
          IconButton(
            onPressed: controller.goToEvents,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: primaryColor,
            ),
          ),
        ]),
        Obx(() => controller.loadingEvent.value &&
                controller.eventResults.value.data!.isEmpty
            ? const CircularProgressIndicator.adaptive().centered()
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.eventResults.value.data!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final event = controller.eventResults.value.data![index];
                  return EventCard(
                    event: event,
                    onTap: () => controller.openDetail(event),
                  ).w(150);
                },
              ).h(210)),
        HStack([
          'Special Offers'.text.xl.semiBold.make().expand(),
          IconButton(
            onPressed: controller.goToPromo,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: primaryColor,
            ),
          ),
        ]),
        Obx(
          () => controller.loadingPromo.value &&
                  controller.promoResults.value.data!.isEmpty
              ? const CircularProgressIndicator.adaptive().centered()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 250,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.promoResults.value.data!.length,
                  itemBuilder: (context, index) {
                    final promo = controller.promoResults.value.data![index];
                    return PromoCard(
                      promo: promo,
                      onTap: () => controller.openPromoDetail(promo),
                    );
                  },
                ),
        ),
        HStack([
          'Ongoing Movies'.text.xl.semiBold.make().expand(),
          IconButton(
            onPressed: controller.goToMovies,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: primaryColor,
            ),
          ),
        ]),
        Obx(() => controller.loadingMovie.value &&
                controller.movieResults.value.data!.isEmpty
            ? const CircularProgressIndicator.adaptive().centered()
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.movieResults.value.data!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final movie = controller.movieResults.value.data![index];
                  return MovieCard(
                    movie: movie,
                    onTap: () => controller.openMovieDetail(movie),
                  ).w(150);
                },
              ).h(265)),
      ]).scrollVertical().p12().safeArea(),
    );
  }
}
