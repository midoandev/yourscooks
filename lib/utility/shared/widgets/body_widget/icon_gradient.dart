import 'package:flutter/material.dart';

class IconGradient extends StatelessWidget {
  final Widget child;

  const IconGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const RadialGradient(
        center: Alignment.topRight,
        radius: .35,
        colors: [
          Color(0xFF1D74F5),
          Color(0xFFFF0099),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
