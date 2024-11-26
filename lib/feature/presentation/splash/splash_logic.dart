import 'dart:async';

import 'package:get/get.dart';
import 'package:yourscooks/feature/presentation/main/main_ui.dart';

import 'splash_state.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();

  @override
  void onInit() async {
    super.onInit();
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(MainUi.namePath);
    });
  }
}
