import 'package:get/get.dart';
import 'package:yourscooks/utility/network/api_provider.dart';

import '../feature/application/auth_app_service.dart';
import '../feature/infrastructure/data_source/auth_remote_data_source.dart';
import '../feature/infrastructure/repository/auth_repository.dart';
import '../utility/shared/services/storage_service.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService.init());
    Get.put(() => ApiProvider());


    //Module auth
    Get.lazyPut(() => AuthRemoteDataSource(), fenix: true);
    Get.lazyPut(() => AuthRepository(), fenix: true);
    Get.lazyPut(() => AuthAppService(), fenix: true);

  }
}
