import 'package:get/get.dart';

import '../../../application/main_app_service.dart';
import 'search_state.dart';

class SearchLogic extends GetxController {
  final SearchState state = SearchState();
  final _app = Get.find<MainAppService>();

  @override
  onReady() {
    super.onReady();
  }

  // Future<void> searchProduct(keyword) async {
  //   state.isRefresh.value = true;
  //   final res = await _app.searchRecipes(state.searchText.value);
  //   res.fold((l) {
  //     Get.log('dsafdsfs $l');
  //     if (state.lastKey.value != null) return;
  //     state.listData.clear();
  //     state.isRefresh.value = false;
  //     state.hasMore.value = false;
  //     Left(l);
  //   }, (r) {
  //     Get.log('sdkfmadsknfk ${r.length} isNull ${state.listData.isEmpty}');
  //     if (r.isEmpty) {
  //       state.hasMore.value = false;
  //       state.isRefresh.value = false;
  //       return;
  //     }
  //     // state.pageCount.value = state + 10;
  //     if (state.lastKey.value != null) {
  //       state.listData.addAll(r);
  //     } else {
  //       state.listData.assignAll(r);
  //     }
  //     state.listData.refresh();
  //     state.lastKey.value = state.listData.length.toString();
  //     // Get.log('recipe id=${r.last.recipeId} name=${r.last.toJson()}');
  //     state.isRefresh.value = false;
  //   });
  // }

  Future<void> refreshLoader() async {
    state.listData.clear();
    // await fetchProduct();
    // await Future.delayed(const Duration(seconds: 0, milliseconds: 100));
    Get.log('dsakfdnk');
  }

  void searchRecipes(String value) async {
    Get.log('dsakfdnk $value');
    state.isRefresh.value = true;
    final res = await _app.getRecipes(keyword: value);
    res.fold((l) {
      Get.log('dsafdsfs $l');
      state.listData.clear();
      state.isRefresh.value = false;
    }, (r) {
      Get.log('sdkfmadsknfk ${r.recipes.length} isNull ${state.listData.isEmpty}');
      if (r.recipes.isEmpty) {
        state.isRefresh.value = false;
        return;
      }
      state.listData.assignAll(r.recipes);
      state.listData.refresh();
      state.isRefresh.value = false;
    });
  }
}
