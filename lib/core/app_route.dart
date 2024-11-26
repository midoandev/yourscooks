import 'package:get/get.dart';
import 'package:yourscooks/feature/presentation/main/main_binding.dart';
import 'package:yourscooks/feature/presentation/main/main_ui.dart';
import 'package:yourscooks/feature/presentation/splash/splash_binding.dart';

import '../feature/presentation/splash/splash_ui.dart';

class AppRouter {
  static const initialRoute = SplashUi.namePath;

  static final routes = [
    GetPage(
      name: SplashUi.namePath,
      page: () => SplashUi(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: MainUi.namePath,
      page: () => MainUi(),
      binding: MainBinding(),
      transition: Transition.fadeIn
    ),
  ];
}
