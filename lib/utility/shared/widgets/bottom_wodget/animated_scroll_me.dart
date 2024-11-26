import 'package:flutter/material.dart';

class BlinkingArrowAnimation extends StatefulWidget {
  const BlinkingArrowAnimation({super.key});

  @override
  BlinkingArrowAnimationState createState() => BlinkingArrowAnimationState();
}

class BlinkingArrowAnimationState extends State<BlinkingArrowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Membuat AnimationController dengan durasi 500ms dan repeat
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Column(
        children: [
          Icon(Icons.keyboard_double_arrow_up_outlined,
              color: Colors.white.withOpacity(.5), size: 20.0),
          const SizedBox(height: 4),
          Text(
            "swipe-up",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              color:  Colors.white.withOpacity(.5),
              fontWeight: FontWeight.w400,
              letterSpacing: 3.2,
            ),
          ),
        ],
      ),
    );
  }
}
