import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/application/main_app_service.dart';
import 'package:yourscooks/feature/presentation/main/main_logic.dart';
import 'package:yourscooks/feature/presentation/main/search/search_ui.dart';

import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  final _app = Get.find<MainAppService>();

  var debounceTimer = Duration(milliseconds: 500);

  @override
  void onInit() {
    fetchProduct();
    super.onInit();
    // state.scrollController.value.addListener(
    //   () async {
    //     state.isSliverScroll.value =
    //         state.scrollController.value.offset >= 150.0;
    //     if (state.scrollController.value.position.pixels >=
    //             state.scrollController.value.position.maxScrollExtent - 50 &&
    //         state.loadingMore.isFalse) {
    //       state.loadingMore.value = true;
    //       state.loadingMore.refresh();
    //       await Future.delayed(Duration(seconds: 0, milliseconds: 600));
    //       await fetchProduct();
    //       state.loadingMore.value = false;
    //     }
    //   },
    // );
  }

  User? get getUser {
    final logicMain = Get.find<MainLogic>();
    return logicMain.state.userProfile.value;
  }

  Future<void> loadMore() async {
      state.loadingMore.value = true;
      state.loadingMore.refresh();
      await Future.delayed(Duration(seconds: 0, milliseconds: 600));
      await fetchProduct();
      state.loadingMore.value = false;
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
      Get.log(
          'sdkfmadsknfk ${r.recipes.length} isNull ${state.listData.isEmpty}');
      if (r.recipes.isEmpty) {
        state.hasMore.value = false;
        state.isRefresh.value = false;
        return;
      }
      // state.pageCount.value = state + 10;
      if (state.lastKey.value != null) {
        state.listData.addAll(r.recipes);
      } else {
        state.listData.assignAll(r.recipes);
      }
      state.listData.refresh();
      state.lastKey.value = r.lastDocument;
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

  void toSearch() => Get.toNamed(SearchUi.namePath);

  @override
  void dispose() {
    state.scrollController.value.dispose();
    super.dispose();
  }
}
