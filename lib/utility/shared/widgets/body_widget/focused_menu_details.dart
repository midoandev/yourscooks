import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FocusedMenuDetails extends StatelessWidget {
  final Offset childOffset;
  final Size childSize;
  final Widget menuContent, child, childReaction;
  final int menuContentHeight;

  // final GlobalKey? key;

  const FocusedMenuDetails(
      {super.key,
      required this.menuContent,
      required this.childOffset,
      required this.childSize,
      required this.child,
      required this.childReaction,
      required this.menuContentHeight});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final maxMenuWidth = size.width * (context.isTablet ? .3 : .4);
    final menuHeight = menuContentHeight == 0
        ? 338.0
        : menuContentHeight * 44; //size.height * .4;
    final leftOffset = (childOffset.dx + maxMenuWidth) < size.width
        ? childOffset.dx + 8
        : (childOffset.dx - maxMenuWidth + childSize.width) - 8;
    final topOffset =
        (childOffset.dy + (menuHeight + 8) + childSize.height) < size.height
            ? childOffset.dy + (childSize.height + 8)
            : childOffset.dy - (menuHeight + 8);

    final bottomOffset =
        (childOffset.dy + (menuHeight + 8) + childSize.height) < size.height
            ? childOffset.dy - 55
            : childOffset.dy + childSize.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 6),
                  child: Container(
                    color: Colors.white.withOpacity(0.05),
                  ),
                )),
            Positioned(
              top: topOffset,
              left: leftOffset,
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 200),
                builder: (ctx, double value, child) {
                  return Transform.scale(
                    scale: value,
                    alignment: Alignment.center,
                    child: child,
                  );
                },
                tween: Tween(begin: 0.0, end: 1.0),
                child: Container(
                    key: key,
                    // width: maxMenuWidth,
                    // height: menuHeight,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 10,
                            spreadRadius: 1,
                          )
                        ]),
                    child: menuContent),
              ),
            ),
            Positioned(
                top: bottomOffset,
                left: leftOffset,
                child: SizedBox(
                  height: 49,
                  width: maxMenuWidth,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 15,
                          width: maxMenuWidth,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white.withOpacity(.1),
                            // gradient: LinearGradient(
                            //   begin: Alignment.centerLeft,
                            //   end: Alignment.centerRight,
                            //   colors: [
                            //     hexToColor('#F5F5F5'),
                            //     Colors.white,
                            //     Colors.white,
                            //     Colors.white,
                            //     Colors.white,
                            //     hexToColor('#F5F5F5'),
                            //   ], // Gradient from https://learnui.design/tools/gradient-generator.html
                            // )
                          ),
                        ),
                      ),
                      childReaction,
                    ],
                  ),
                )),
            Positioned(
                top: childOffset.dy,
                left: childOffset.dx,
                child: AbsorbPointer(
                    absorbing: true,
                    child: SizedBox(
                        width: childSize.width,
                        height: childSize.height,
                        child: child))),
          ],
        ),
      ),
    );
  }
}
