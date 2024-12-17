import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourscooks/utility/generate/assets.gen.dart';

class LoadingDialog {
  static void show() {
    Get.dialog(
      Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(child: AppImages.vector.appIcon.image(height: 48)),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hide() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
