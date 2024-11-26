import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourscooks/utility/generate/assets.gen.dart';

import 'splash_logic.dart';
import 'splash_state.dart';

class SplashUi extends StatelessWidget {
  static const String namePath = '/';

  SplashUi({super.key});

  final logic = Get.put(SplashLogic());
  final state = Get.find<SplashLogic>().state;

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logoWidth: 48,
      logo: AppImages.vector.appIcon.image(),
      showLoader: false,
    );
  }
}
