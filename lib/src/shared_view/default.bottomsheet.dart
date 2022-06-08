import 'package:ciwalk/src/misc/ui.spacer.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DefaultBottomSheet extends StatelessWidget {
  final List<Widget> children;
  const DefaultBottomSheet({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VStack([
      const Divider(
        color: Colors.black12,
        height: 25,
        endIndent: 165,
        indent: 165,
        thickness: 5,
      ),
      UiSpacer.verticalSpace(space: 10),
      VStack(children),
    ])
        .p12()
        .safeArea()
        .box
        .white
        .roundedLg
        .withConstraints(const BoxConstraints(
          minHeight: 100,
          maxHeight: 700,
        ))
        .make();
  }
}
