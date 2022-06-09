import 'package:cached_network_image/cached_network_image.dart';
import 'package:ciwalk/src/misc/ui.spacer.dart';
import 'package:ciwalk/src/themes/colors.dart';
import 'package:ciwalk/src/view/homepage/component/movie.card.dart';
import 'package:ciwalk/src/view_models/movie_detail.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MovieDetailScreen extends GetView<MovieDetailViewModel> {
  static const routeName = '/movies/detail';
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MovieDetailViewModel());
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(
        () => controller.isLoading.value &&
                controller.result.value.data?.slug == null
            ? const CircularProgressIndicator.adaptive().centered()
            : VStack([
                ZStack(
                  [
                    CachedNetworkImage(
                      imageUrl: controller.result.value.data!.thumbnail!.imageUrl!,
                      fit: BoxFit.cover,
                    ).h(300).wFull(context),
                    VStack([
                      HStack([
                        (controller.result.value.data?.title ?? '-')
                            .text
                            .white
                            .ellipsis
                            .maxLines(2)
                            .semiBold
                            .make()
                            .expand(),
                        HStack([
                          const Icon(Icons.schedule_rounded),
                          UiSpacer.horizontalSpace(space: 5),
                          'Schedule'.text.make(),
                        ])
                            .p4()
                            .continuousRectangle(
                              height: 40,
                              width: 100,
                              backgroundColor: primaryColor,
                            )
                            .onTap(controller.openSchedule)
                            .p4(),
                        HStack([
                          const Icon(Icons.play_arrow_rounded),
                          UiSpacer.horizontalSpace(space: 5),
                          'Trailer'.text.make(),
                        ])
                            .continuousRectangle(
                              height: 40,
                              width: 80,
                              backgroundColor: primaryColor,
                            )
                            .onTap(controller.openTrailer),
                      ]),
                    ])
                        .p12()
                        .box
                        .color(Colors.black38)
                        .make()
                        .wFull(context)
                        .hFull(context)
                        .positioned(top: 250),
                    const BackButton().positioned(top: 45),
                  ],
                ),
                UiSpacer.verticalSpace(),
                (controller.result.value.data?.body ?? '-').text.white.make(),
                UiSpacer.verticalSpace(),
                'Ongoing Movies'.text.xl.semiBold.white.make(),
                UiSpacer.verticalSpace(),
                controller.loadingRelatedMovies.value &&
                        controller.movieResults.value.data!.isEmpty
                    ? const CircularProgressIndicator.adaptive().centered()
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.movieResults.value.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final movie =
                              controller.movieResults.value.data![index];
                          return MovieCard(
                            movie: movie,
                            textColor: Colors.white,
                            onTap: () => controller.openMovieDetail(movie),
                          ).w(150).p4();
                        },
                      ).h(275),
              ]).scrollVertical(),
      ),
    );
  }
}
