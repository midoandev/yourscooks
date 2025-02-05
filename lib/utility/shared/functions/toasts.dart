import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Toasts {
  static void show(String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color? backgroundColor,
    Color? textColor,
    double fontSize = 15.0,
    Toast toastLength = Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength == Toast.LENGTH_SHORT ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor ?? Get.theme.colorScheme.surfaceContainerHighest,
      textColor: textColor ??  Get.theme.colorScheme.onSurface,
      fontSize: fontSize,
    );
  }
  static void cancel() => Fluttertoast.cancel();
}
