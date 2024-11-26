
import 'package:flutter/material.dart';

class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({super.parent});

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    final maxScrollExtent = position.maxScrollExtent;
    final pixels = value.clamp(0.8, maxScrollExtent) - value;

    if (position.pixels == maxScrollExtent && value > position.pixels) {
      // mematikan scroll ke bawah saat sudah mencapai batas bawah
      return pixels;
    } else {
      return super.applyBoundaryConditions(position, value);
    }
  }
}