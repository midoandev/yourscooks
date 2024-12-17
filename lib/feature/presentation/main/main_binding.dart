import 'package:get/get.dart';
import 'package:yourscooks/feature/application/main_app_service.dart';

import '../../infrastructure/data_source/main_remote_data_source.dart';
import '../../infrastructure/repository/main_repository.dart';
import 'main_logic.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    //Module main
    Get.lazyPut(() => MainRemoteDataSource());
    Get.lazyPut(() => MainRepository());
    Get.lazyPut(() => MainAppService());

    Get.lazyPut(() => MainLogic());
  }
}
