import 'dart:async';

import 'package:get/get.dart';
import 'package:yourscooks/feature/application/auth_app_service.dart';
import 'package:yourscooks/feature/presentation/login/login_ui.dart';
import 'package:yourscooks/feature/presentation/main/main_ui.dart';

import 'splash_state.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();
  final _app = Get.find<AuthAppService>();

  @override
  void onInit() async {
    super.onInit();
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(
          _app.getUser().isLeft() ? LoginUi.namePath : MainUi.namePath);
    });
  }
}
