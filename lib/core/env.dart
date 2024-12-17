import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:yourscooks/core/dependency_injection.dart';

import '../firebase_options.dart';
import '../utility/shared/services/storage_service.dart';
import 'app_component.dart';

enum EnvType { development, production }

class Env {
  static late Env value;

  String get appName => dotenv.env['APP_NAME']!;

  String get appIdWeb => dotenv.env['appIdWeb']!;

  String get appIdAndroid => dotenv.env['appIdAndroid']!;

  String get appIdAndroidDev => dotenv.env['appIdAndroidDev']!;

  String get appIdIos => dotenv.env['appIdIos']!;

  String get messagingSenderId => dotenv.env['messagingSenderId']!;

  String get projectId => dotenv.env['projectId']!;

  String get authDomain => dotenv.env['authDomain']!;

  String get storageBucket => dotenv.env['storageBucket']!;

  String get apiKeyWeb => dotenv.env['apiKeyWeb']!;

  String get apiKeyAndroid => dotenv.env['apiKeyAndroid']!;

  String get apiKeyIos => dotenv.env['apiKeyIos']!;

  String get iosBundleId => dotenv.env['iosBundleId']!;
  EnvType environmentType = EnvType.production;

  Env() {
    value = this;
    _init();
  }

  void _init() async {
    print('appFlavor $appFlavor');

    WidgetsFlutterBinding.ensureInitialized();
    await DependencyInjection.init();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final isDark =
        await StorageService.getPrefBool(key: StorageEnum.themeIsDark);
    Get.log('isDarkFirst $isDark');

    final themeDefault = isDark ? ThemeMode.dark : ThemeMode.light;

    runApp(AppComponent(themeMode: themeDefault));
  }
}
