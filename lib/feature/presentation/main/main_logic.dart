import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../application/auth_app_service.dart';
import 'main_state.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();
  final _app = Get.find<AuthAppService>();

  @override
  void onReady() {
    fetchUser();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchUser() {
    final userData = _app.getUser();
    userData.fold((l) => Left(l), (r) {
      state.userProfile.value = r;
    });
  }
}
