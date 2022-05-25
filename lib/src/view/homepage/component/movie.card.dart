import 'package:cached_network_image/cached_network_image.dart';
import 'package:ciwalk/src/data/models/movie/movie.dart';
import 'package:ciwalk/src/misc/ui.spacer.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function()? onTap;
  final Color? textColor;
  const MovieCard({
    Key? key,
    required this.movie,
    this.onTap,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: VStack([
        CachedNetworkImage(
          imageUrl: movie.thumbnail!.url.toString(),
        ).cornerRadius(20),
        UiSpacer.verticalSpace(space: 10),
        (movie.title ?? '-').text.ellipsis.color(textColor!).maxLines(2).make(),
      ]).p4(),
    );
  }
}
