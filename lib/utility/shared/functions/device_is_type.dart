import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceIsType {
  static bool get isSmall {
    var shortestSide = Get.height;
    return shortestSide < 800;
  }

  static bool get isPhone {
    var shortestSide = MediaQuery.of(Get.context!).size.shortestSide;
    return shortestSide < 550;
  }
}