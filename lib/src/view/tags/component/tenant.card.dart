import 'package:cached_network_image/cached_network_image.dart';
import 'package:ciwalk/src/data/models/tenant/tenant.dart';
import 'package:ciwalk/src/misc/ui.spacer.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TenantCard extends StatelessWidget {
  final Tenant tenant;
  final Function()? onTap;
  const TenantCard({
    Key? key,
    required this.tenant,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: VStack([
        tenant.thumbnail?.url == null
            ? 'No Image Found'
                .text
                .white
                .makeCentered()
                .box
                .gray700
                .make()
                .cornerRadius(20)
                .h(120)
            : CachedNetworkImage(
                imageUrl: tenant.thumbnail!.imageUrl.toString(),
              ).cornerRadius(20).h(120).centered(),
        UiSpacer.verticalSpace(space: 10),
        (tenant.name ?? '-').text.ellipsis.make(),
        UiSpacer.verticalSpace(space: 10),
        (tenant.type ?? '-').text.gray500.make(),
      ]).p4(),
    );
  }
}
