import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';

class SwipeWidget extends StatefulWidget {
  final Widget child;
  final Function(bool) callback;
  final bool onRight;
  final bool? disable;

  const SwipeWidget(
      {super.key,
      required this.child,
      required this.callback,
      required this.onRight,
      this.disable});

  @override
  SwipeWidgetState createState() => SwipeWidgetState();
}

class SwipeWidgetState extends State<SwipeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var _dragAlignment = Alignment.centerRight;

  late Animation<Alignment> _animation;

  final _spring = const SpringDescription(
    mass: 10,
    stiffness: 1500,
    damping: 4,
  );

  double _normalizeVelocity(Offset velocity, Size size) {
    final normalizedVelocity = Offset(
      velocity.dx / size.width,
      velocity.dy / size.height,
    );
    return -normalizedVelocity.distance;
  }

  void _runAnimation(Offset velocity, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: widget.onRight ? Alignment.centerRight : Alignment.centerLeft,
      ),
    );

    final simulation =
        SpringSimulation(_spring, 0.0, 1.0, _normalizeVelocity(velocity, size));

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    setState(() => _dragAlignment =
        widget.onRight ? Alignment.centerRight : Alignment.centerLeft);
    _controller = AnimationController.unbounded(vsync: this)
      ..addListener(() => setState(() => _dragAlignment = _animation.value));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanStart: (details) => _controller.stop(canceled: true),
      onPanUpdate: (details) {
        if (widget.disable == true) return;
        setState(
          () => _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            0,
          ),
        );
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);
        Get.log('detailPanEnd ${details.velocity.pixelsPerSecond.dx > 0}');
        var bool = details.velocity.pixelsPerSecond.dx > 0;
        widget.callback(bool);
      },
      child: Align(
        alignment: _dragAlignment,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastLinearToSlowEaseIn,
          child: widget.child,
        ),
      ),
    );
  }
}
