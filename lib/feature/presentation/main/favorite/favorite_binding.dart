import 'package:get/get.dart';

import 'favorite_logic.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteLogic());
  }
}
