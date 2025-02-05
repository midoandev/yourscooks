import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/application/auth_app_service.dart';
import 'package:yourscooks/feature/application/main_app_service.dart';

import 'detail_recipes_state.dart';

class DetailRecipesLogic extends GetxController {
  final DetailRecipesState state = DetailRecipesState();
  final _app = Get.find<MainAppService>();
  final _auth = Get.find<AuthAppService>();

  @override
  void onInit() {
    fetchDataUser();
    fetchIsFavorite();
    Get.log('onready detail');
    super.onInit();
  }

  @override
  void onClose() {
    Get.log('onclose detail');
    state.isFavorite.value = false;
    state.recipes.value = null;
    super.onClose();
  }

  void backPress() => Get.back();

  void toggleFavorite() async {
    final id = state.recipes.value?.recipeId;
    Get.log('asdkflmsdk $id');
    if (id == null) return;
    final res = await _app.setFavorite(
        idRecipes: id, userId: state.userProfile.value?.uid ?? '');
    res.fold(
      (l) {
        Get.log('leftToggleFavorite $l');
        return;
      },
      (r) {
        state.isFavorite.toggle();
        state.isFavorite.refresh();
      },
    );
  }

  void fetchDataUser() {
    final userData = _auth.getUser();
    userData.fold((l) => Left(l), (r) {
      state.userProfile.value = r;
    });
  }

  void fetchIsFavorite() async {
    final id = state.recipes.value?.recipeId ?? 0;
    final userData = await _app.isFavorite(
        idRecipes: id, userId: state.userProfile.value?.uid ?? '');
    userData.fold((l) => Left(l), (r) {
      state.isFavorite.value = r;
      state.isFavorite.refresh();
    });
  }
}
