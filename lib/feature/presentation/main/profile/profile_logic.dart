import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/application/auth_app_service.dart';
import 'package:yourscooks/feature/application/main_app_service.dart';

import '../../../../utility/shared/functions/custom_dialog_function.dart';
import '../../login/login_ui.dart';
import '../../splash/splash_ui.dart';
import 'profile_state.dart';

class ProfileLogic extends GetxController {
  final ProfileState state = ProfileState();
  final _appAuth = Get.find<AuthAppService>();
  final _app = Get.find<MainAppService>();

  @override
  void onReady() {
    fetchDataUser();
    super.onReady();
  }

  Future<void> signOut() async {
    CustomDialog.showConfirmDialog(
      'Are you sure want to logout?',
      positiveAction: () async {
        // await _app.logout();
        // Get.offAllNamed(BoardingUi.namePath);
      },
    );
    // await _appAuth.signOut();
    // Get.offAllNamed(LoginUi.namePath);
  }

  void fetchDataUser() {
    final userData = _appAuth.getUser();
    userData.fold((l) => Left(l), (r) {
      state.userProfile.value = r;
    });
  }

  void changeTheme(bool isDark) async {
    // var theme = Get.theme;
    Get.log('dkflmskd $isDark');
    state.isDarkMode.value = isDark;
    state.isDarkMode.refresh();
    // Get.changeThemeMode(value ? ThemeMode.light : ThemeMode.dark);
    await _app.changeTheme(isDark).then((value) {
      Get.offAllNamed(SplashUi.namePath);
    });
  }
}
