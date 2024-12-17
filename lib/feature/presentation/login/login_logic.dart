
import 'package:get/get.dart';
import 'package:yourscooks/feature/application/auth_app_service.dart';
import 'package:yourscooks/feature/presentation/main/main_ui.dart';

import '../../../utility/shared/utils/toasts.dart';
import 'login_state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();
  final _app = Get.find<AuthAppService>();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void goAuthApple() async {}

  void goAuthGoogle() async {
    final res = await _app.signWithGoogle();
    res.fold(
      (l) {
        Toasts.show('something error $l');
      },
      (r) {
        Get.offNamed(MainUi.namePath);
      },
    );
  }
}
