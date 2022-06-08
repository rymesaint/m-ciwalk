import 'package:ciwalk/src/shared_view/default.bottomsheet.dart';
import 'package:ciwalk/src/view_models/tenant.vm.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TenantLocationsBottomsheet extends StatelessWidget {
  final TenantViewModel vm;
  const TenantLocationsBottomsheet({Key? key, required this.vm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultBottomSheet(
      children: [
        'Locations'.text.semiBold.xl.make(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final location = vm.tenant.value.locations?[index];
            return ListTile(title: (location?.name ?? '-').text.make());
          },
          itemCount: vm.tenant.value.locations?.length,
        )
      ],
    );
  }
}
