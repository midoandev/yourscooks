
import 'package:get/get.dart';
import 'package:yourscooks/feature/application/auth_app_service.dart';
import 'package:yourscooks/feature/presentation/main/main_ui.dart';

import '../../../utility/shared/functions/toasts.dart';
import 'login_state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();
  final _app = Get.find<AuthAppService>();

  void goAuthApple() async {

    Toasts.show('Developer not have account apple developer');
  }

  void goAuthGoogle() async {
    final res = await _app.signWithGoogle();
    res.fold(
      (l) {
        Toasts.show('something error');
      },
      (r) {
        Get.offNamed(MainUi.namePath);
      },
    );
  }
}
