import 'package:get/get.dart';
import '../utility/network/api_provider.dart';
import '../utility/shared/services/storage_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(ApiProvider());
    Get.put(StorageService.init());
    //
    // //Module main
    // Get.lazyPut(() => MainRemoteDataSource(), fenix: true);
    // Get.lazyPut(() => MainLocalDataSource(), fenix: true);
    // Get.lazyPut(() => MainRepository(), fenix: true);
    // Get.lazyPut(() => MainAppService(), fenix: true);
  }
}
