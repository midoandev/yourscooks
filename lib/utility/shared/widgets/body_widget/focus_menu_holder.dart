import 'package:flutter/material.dart';

import 'focused_menu_details.dart';

class FocusedMenuHolder extends StatefulWidget {
  final Widget child, menuContent, childReaction;
  final bool? disable;
  final int menuContentHeight;

  const FocusedMenuHolder(
      {super.key,
      required this.child,
      required this.menuContent,
      required this.childReaction,
      this.disable,
      this.menuContentHeight = 0});

  @override
  FocusedMenuHolderState createState() => FocusedMenuHolderState();
}

class FocusedMenuHolderState extends State<FocusedMenuHolder> {
  GlobalKey containerKey = GlobalKey();
  Offset childOffset = const Offset(0, 0);
  late Size childSize;

  getOffset() {
    RenderBox? renderBox =
        containerKey.currentContext!.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    setState(() {
      childOffset = Offset(offset.dx, offset.dy);
      childSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: containerKey,
        onLongPress: () async {
          if (widget.disable == true) return;
          getOffset();
          await Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    animation = Tween(begin: 0.0, end: 1.0).animate(animation);
                    return FadeTransition(
                      opacity: animation,
                      child: FocusedMenuDetails(
                        menuContent: widget.menuContent,
                        childOffset: childOffset,
                        childSize: childSize,
                        childReaction: widget.childReaction,
                        menuContentHeight: widget.menuContentHeight,
                        child: widget.child,
                      ),
                    );
                  },
                  fullscreenDialog: true,
                  opaque: false));
        },
        child: widget.child);
  }
}
