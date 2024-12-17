import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourscooks/utility/shared/constants/app_theme.dart';

import 'app_route.dart';
import 'binding.dart';
import 'env.dart';

@immutable
class AppComponent extends StatelessWidget {
  final ThemeMode themeMode;

  const AppComponent({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    final myApp = GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: AppRouter.initialRoute,
      getPages: AppRouter.routes,
      scrollBehavior: AppScrollBehavior(),
      transitionDuration: const Duration(milliseconds: 500),
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      themeMode: themeMode,
      title: Env.value.appName,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
    );

    return myApp;
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
