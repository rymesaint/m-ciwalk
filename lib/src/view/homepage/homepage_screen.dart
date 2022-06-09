import 'package:ciwalk/src/misc/ui.spacer.dart';
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
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 140,
            floating: true,
            pinned: true,
            actions: [
              IconButton(
                onPressed: controller.openMap,
                icon: const Icon(Icons.map_rounded),
                color: primaryColor,
              ),
              IconButton(
                onPressed: controller.openMenu,
                icon: const Icon(Icons.menu),
                color: primaryColor,
              ),
            ],
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/ciwalk-bg.jpeg',
                fit: BoxFit.cover,
                color: Colors.black26,
                colorBlendMode: BlendMode.colorBurn,
              ).cornerRadius(20),
              centerTitle: false,
              title: 'm-Ciwalk'.text.color(primaryColor).semiBold.xl3.make(),
              titlePadding: const EdgeInsets.only(bottom: 10, left: 20),
            ),
          ),
        ],
        body: VStack([
          Obx(() => controller.tagResults.value.data!.isEmpty
              ? UiSpacer.emptySpace()
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.tagResults.value.data?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final tag = controller.tagResults.value.data![index];
                    return Chip(
                      label: (tag.name ?? '-').text.make(),
                      avatar: const Icon(Icons.tag_rounded),
                    )
                        .onTap(() => controller.openTag(tag))
                        .marginSymmetric(horizontal: 4);
                  },
                ).h(50)),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
        ]).p8().scrollVertical(),
      ),
    );
  }
}
