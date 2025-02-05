import 'package:get/get.dart';

import 'detail_recipes_logic.dart';

class DetailRecipesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailRecipesLogic());
  }
}
