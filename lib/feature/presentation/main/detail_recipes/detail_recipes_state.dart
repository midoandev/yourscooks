import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../domain/entities/recipes.dart';

class DetailRecipesState {
  DetailRecipesState() {
    final args = Get.arguments;
    recipes.value = args;
  }
  var recipes = Rxn<Recipes>();

  var userProfile = Rxn<User>();
  var isFavorite = false.obs;
}
