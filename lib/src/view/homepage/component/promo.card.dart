import 'package:cached_network_image/cached_network_image.dart';
import 'package:ciwalk/src/data/models/promo/promo.dart';
import 'package:ciwalk/src/misc/ui.spacer.dart';
import 'package:ciwalk/src/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;
  final Function()? onTap;
  const PromoCard({
    Key? key,
    required this.promo,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: VStack([
        ZStack([
          CachedNetworkImage(
            imageUrl: promo.thumbnail!.imageUrl.toString(),
          ).cornerRadius(20),
          (promo.statusPromo ?? '')
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
        (promo.title ?? '-').text.ellipsis.make(),
        UiSpacer.verticalSpace(space: 10),
        (promo.tenant?.name ?? '-').text.gray500.make(),
      ]).p4(),
    );
  }
}
