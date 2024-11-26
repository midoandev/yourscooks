import 'package:flutter/material.dart';

class ButtonInkWell extends StatelessWidget {
  final Widget child;
  final Function() onPress;
  final double? valueBorder;
  final Function()? onLongPress;

  const ButtonInkWell(
      {super.key,
      required this.child,
      required this.onPress,
      this.valueBorder,
      this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPress,
        onLongPress: onLongPress ?? () {},
        borderRadius: BorderRadius.circular(
            valueBorder == null ? 15 : valueBorder as double),
        child: Container(child: child),
      ),
    );
  }
}
