import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_logic.dart';
import 'main_state.dart';

class MainUi extends StatelessWidget {
  static const String namePath = '/main';
  MainUi({super.key});

  final logic = Get.put(MainLogic());
  final state = Get.find<MainLogic>().state;
  @override
  Widget build(BuildContext context) {

    return Scaffold();
  }
}
