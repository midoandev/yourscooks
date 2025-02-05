import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/application/main_app_service.dart';
import 'package:yourscooks/feature/domain/entities/recipes.dart';
import 'package:yourscooks/feature/presentation/main/detail_recipes/detail_recipes_ui.dart';
import 'package:yourscooks/feature/presentation/main/main_logic.dart';

import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  final _app = Get.find<MainAppService>();

  @override
  void onInit() {
    fetchProduct();
    super.onInit();
    state.scrollController.addListener(() {
      // Get.log('scrollController.offset ${state.scrollController.offset}');
      state.isSliverScroll.value = state.scrollController.offset >= 150.0;
      if (state.loadingMore.isFalse) _scrollListener();
    });
  }

  User? get getUser {
    final logicMain = Get.find<MainLogic>();
    return logicMain.state.userProfile.value;
  }

  Future<void> _scrollListener() async {
    // if (state.scrollController.offset >=
    //         state.scrollController.position.maxScrollExtent &&
    //     !state.scrollController.position.outOfRange) {
    if (state.scrollController.position.extentAfter < 500) {
      state.loadingMore.value = true;
      await Future.delayed(Duration(seconds: 0, milliseconds: 600));
      await fetchProduct();
      state.loadingMore.value = false;
    }
  }

  Future<void> fetchProduct() async {
    state.isRefresh.value = true;
    final res = await _app.getRecipes(lastKey: state.lastKey.value);
    res.fold((l) {
      Get.log('dsafdsfs $l');
      if (state.lastKey.value != null) return;
      state.listData.clear();
      state.isRefresh.value = false;
      state.hasMore.value = false;
      Left(l);
    }, (r) {
      Get.log('sdkfmadsknfk ${r.length} isNull ${state.listData.isEmpty}');
      if (r.isEmpty) {
        state.hasMore.value = false;
        state.isRefresh.value = false;
        return;
      }
      // state.pageCount.value = state + 10;
      if (state.lastKey.value != null) {
        state.listData.addAll(r);
      } else {
        state.listData.assignAll(r);
      }
      state.listData.refresh();
      state.lastKey.value = state.listData.length.toString();
      // Get.log('recipe id=${r.last.recipeId} name=${r.last.toJson()}');
      state.isRefresh.value = false;
    });
  }
  Future<void> refreshLoader() async {
    state.listData.clear();
    state.lastKey.value = null;
    await fetchProduct();
    await Future.delayed(const Duration(seconds: 0, milliseconds: 100));
    Get.log('dsakfdnk');
  }

  void toDetailRecipes(Recipes item) {
    Get.toNamed(DetailRecipesUi.namePath, arguments: item);
  }
}
