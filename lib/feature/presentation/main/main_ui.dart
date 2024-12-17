import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:yourscooks/utility/shared/utils/number_helper.dart';

import 'main_logic.dart';

class MainUi extends StatelessWidget {
  static const String namePath = '/main';

  MainUi({super.key});

  final logic = Get.put(MainLogic());
  final state = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          body: state.widgets[state.currentIndex.value],
          bottomNavigationBar: Container(
            color: Get.theme.cardColor,
            child: Obx(() {
              return SalomonBottomBar(
                backgroundColor: Get.theme.cardColor,
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                currentIndex: state.currentIndex.value,
                onTap: (i) => state.currentIndex.value = i,
                items: [
                  SalomonBottomBarItem(
                    icon: Icon(FeatherIcons.home),
                    title: Text("Home"),
                  ),
                  // SalomonBottomBarItem(
                  //   icon: Icon(FeatherIcons.search),
                  //   title: Text("Search"),
                  // ),
                  SalomonBottomBarItem(
                    icon: Icon(FeatherIcons.heart),
                    title: Text("Likes"),
                  ),
                  SalomonBottomBarItem(
                    icon: Icon(FeatherIcons.user),
                    title: Text("Profile"),
                  ),
                ],
              );
            }),
          ));
    });
  }
}
