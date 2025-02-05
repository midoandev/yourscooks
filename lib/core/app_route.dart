import 'package:get/get.dart';
import 'package:yourscooks/feature/presentation/login/login_binding.dart';
import 'package:yourscooks/feature/presentation/login/login_ui.dart';
import 'package:yourscooks/feature/presentation/main/detail_recipes/detail_recipes_binding.dart';
import 'package:yourscooks/feature/presentation/main/detail_recipes/detail_recipes_ui.dart';
import 'package:yourscooks/feature/presentation/main/main_binding.dart';
import 'package:yourscooks/feature/presentation/main/main_ui.dart';
import 'package:yourscooks/feature/presentation/splash/splash_binding.dart';

import '../feature/presentation/main/favorite/favorite_binding.dart';
import '../feature/presentation/main/home/home_binding.dart';
import '../feature/presentation/main/profile/profile_binding.dart';
import '../feature/presentation/main/search/search_binding.dart';
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
      name: LoginUi.namePath,
      page: () => LoginUi(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: MainUi.namePath,
      page: () => MainUi(),
      bindings: [
        MainBinding(),
        HomeBinding(),
        SearchBinding(),
        FavoriteBinding(),
        ProfileBinding(),
      ],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: DetailRecipesUi.namePath,
      page: () => DetailRecipesUi(),
      binding: DetailRecipesBinding(),
    ),
  ];
}
