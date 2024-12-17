import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/presentation/main/home/home_ui.dart';
import 'package:yourscooks/utility/generate/assets.gen.dart';
import 'package:yourscooks/utility/shared/utils/number_helper.dart';

import 'login_logic.dart';
import 'login_state.dart';

class LoginUi extends StatelessWidget {
  static const String namePath = '/login';

  LoginUi({super.key});
  final LoginLogic logic = Get.put(LoginLogic());
  final LoginState state = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or Header
            Text(
              'Welcome Yours Cooks!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Sign in with your email to continue',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: logic.goAuthGoogle,  // Gantilah dengan fungsi yang sesuai untuk Google Sign-In
              child: Container(
                height: 50,
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppImages.vector.googleIcon.svg(height: 24),
                    SizedBox(width: 10),
                    Text(
                      'Sign in with Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            16.zh,
            // Apple Sign-In Button
            GestureDetector(
              onTap: logic.goAuthApple,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.apple,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Sign in with Apple',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
