import 'package:cached_network_image/cached_network_image.dart';
import 'package:ciwalk/src/data/models/event/event.dart';
import 'package:ciwalk/src/misc/ui.spacer.dart';
import 'package:ciwalk/src/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Function()? onTap;
  const EventCard({
    Key? key,
    required this.event,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: VStack([
        ZStack([
          CachedNetworkImage(
            imageUrl: event.thumbnail!.imageUrl!,
          ).cornerRadius(20),
          (event.type ?? '')
              .text
              .capitalize
              .white
              .make()
              .box
              .p8
              .rightRounded(value: 20)
              .color(tagLineColor)
              .make(),
        ]),
        UiSpacer.verticalSpace(space: 10),
        (event.title ?? '-').text.ellipsis.make(),
        HStack([
          const Icon(
            Icons.calendar_today_rounded,
            size: 14,
          ),
          UiSpacer.horizontalSpace(space: 5),
          (event.statusEvent ?? '-')
              .text
              .xs
              .gray500
              .ellipsis
              .maxLines(2)
              .make()
              .expand(),
        ]),
      ]).p4(),
    );
  }
}
