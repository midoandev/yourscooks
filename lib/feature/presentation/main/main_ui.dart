import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:yourscooks/utility/shared/utils/number_helper.dart';

import 'main_logic.dart';
import 'main_state.dart';

class MainUi extends StatelessWidget {
  static const String namePath = '/main';

  MainUi({super.key});

  final logic = Get.put(MainLogic());
  final state = Get
      .find<MainLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Get.theme.dividerColor.withOpacity(0.1),
                    blurRadius: 2,
                    offset: Offset(1, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 2, color: Colors.grey.withOpacity(.16))),
            child: Obx(() {
              return SalomonBottomBar(
                backgroundColor: Colors.transparent,
                currentIndex: state.currentIndex.value,
                onTap: (i) => state.currentIndex.value = i,
                items: [

                  /// Home
                  SalomonBottomBarItem(
                    icon: Icon(Icons.home),
                    title: Text("Home"),
                    selectedColor: Colors.purple,
                  ),

                  /// Likes
                  SalomonBottomBarItem(
                    icon: Icon(Icons.favorite_border),
                    title: Text("Likes"),
                    selectedColor: Colors.pink,
                  ),

                  /// Search
                  SalomonBottomBarItem(
                    icon: Icon(Icons.search),
                    title: Text("Search"),
                    selectedColor: Colors.orange,
                  ),

                  /// Profile
                  SalomonBottomBarItem(
                    icon: Icon(Icons.person),
                    title: Text("Profile"),
                    selectedColor: Colors.teal,
                  ),
                ],
              );
            }),
          ),
        ));
  }
}
