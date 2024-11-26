import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Color colorCircle;
  final double? size;
  final bool visible;

  const CircleButton(
      {super.key,
      required this.colorCircle,
      required this.visible,
      this.size = 18});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.circle,
              color: colorCircle),
        ),
      ),
    );
  }
}
