import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/presentation/main/favorite/favorite_ui.dart';
import 'package:yourscooks/feature/presentation/main/home/home_ui.dart';
import 'package:yourscooks/feature/presentation/main/profile/profile_ui.dart';

class MainState {
  var widgets = [HomeUi(), FavoriteUi(), ProfileUi()];
  var currentIndex = 0.obs;

  var userProfile = Rxn<User>();
}
