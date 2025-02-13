import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../application/main_app_service.dart';
import 'search_state.dart';

class SearchLogic extends GetxController {
  final SearchState state = SearchState();
  final _app = Get.find<MainAppService>();

  Future<void> searchProduct(String value) async {
    if (value.isEmpty) return;
    state.searchText.value = value;
    state.isRefresh.value = true;
    final res = await _app.getRecipes(
        keyword: state.searchText.value, lastKey: state.lastKey.value);
    res.fold((l) {
      Get.log('dsafdsfs $l');
      if (state.lastKey.value != null) return;
      state.listData.clear();
      state.listData.refresh();
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
    await searchProduct(state.searchText.value);
    await Future.delayed(const Duration(seconds: 0, milliseconds: 100));
    Get.log('dsakfdnk');
  }

  Future<void> loadMore() async {
    state.loadingMore.value = true;
    state.loadingMore.refresh();
    await Future.delayed(Duration(seconds: 0, milliseconds: 600));
    await searchProduct(state.searchText.value);
    state.loadingMore.value = false;
  }
}
