import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../application/main_app_service.dart';
import '../main_logic.dart';
import '../search/search_ui.dart';
import 'favorite_state.dart';

class FavoriteLogic extends GetxController {
  final FavoriteState state = FavoriteState();
  final _app = Get.find<MainAppService>();

  @override
  void onReady() {
    // fetchProduct();
    super.onReady();
    ever(Get.find<MainLogic>().state.currentIndex, (callback) {
      // Get.log('adklfmdkl $callback');
      if (callback == 1) fetchProduct();
    });
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
    final res = await _app.getFavorites(userId: getUser?.uid ?? '');
    res.fold((l) {
      Get.log('dsafdsfs $l');
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
      state.listData.assignAll(r);

      state.listData.refresh();
      // Get.log('recipe id=${r.last.recipeId} name=${r.last.toJson()}');
      state.isRefresh.value = false;
    });
  }

  Future<void> refreshLoader() async {
    state.listData.clear();
    await fetchProduct();
    await Future.delayed(const Duration(seconds: 0, milliseconds: 100));
    Get.log('dsakfdnk');
  }

  void toSearch() => Get.toNamed(SearchUi.namePath);

}
