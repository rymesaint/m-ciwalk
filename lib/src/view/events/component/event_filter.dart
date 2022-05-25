import 'package:ciwalk/src/misc/ui.spacer.dart';
import 'package:ciwalk/src/view_models/event.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EventFilter extends StatelessWidget {
  final EventViewModel vm;
  const EventFilter({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => VStack([
          'Filters'.text.makeCentered(),
          UiSpacer.verticalSpace(),
          'Sorting'.text.semiBold.make(),
          UiSpacer.verticalSpace(space: 5),
          RadioListTile(
            value: 'desc',
            groupValue: vm.sortBy.value,
            onChanged: vm.changeSortBy,
            title: 'Newest'.text.make(),
            contentPadding: EdgeInsets.zero,
          ),
          RadioListTile(
            value: 'asc',
            groupValue: vm.sortBy.value,
            onChanged: vm.changeSortBy,
            title: 'Oldest'.text.make(),
            contentPadding: EdgeInsets.zero,
          ),
          'Type'.text.semiBold.make(),
          UiSpacer.verticalSpace(space: 5),
          RadioListTile(
            value: '',
            groupValue: vm.type.value,
            onChanged: vm.changeType,
            title: 'All'.text.make(),
            contentPadding: EdgeInsets.zero,
          ),
          RadioListTile(
            value: 'event',
            groupValue: vm.type.value,
            onChanged: vm.changeType,
            title: 'Events'.text.make(),
            contentPadding: EdgeInsets.zero,
          ),
          RadioListTile(
            value: 'exhibition',
            groupValue: vm.type.value,
            onChanged: vm.changeType,
            title: 'Exhibition'.text.make(),
            contentPadding: EdgeInsets.zero,
          ),
        ]).box.white.p12.topRounded(value: 20).make());
  }
}
