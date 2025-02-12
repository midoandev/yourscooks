import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yourscooks/utility/shared/utils/number_helper.dart';

import '../widgets/recipes_widgets.dart';
import 'home_logic.dart';
import 'home_state.dart';

class HomeUi extends StatelessWidget {
  HomeUi({super.key});

  final HomeLogic logic = Get.put(HomeLogic());
  final HomeState state = Get
      .find<HomeLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  onStretchTrigger: () {
                    state.isSliverScroll.value = true;
                    return Future<void>.value();
                  },
                  expandedHeight: 185,
                  pinned: true,
                  title: Obx(() {
                    return Visibility(
                        visible: state.isSliverScroll.value,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: 16.ph,
                          child: Row(
                            children: [
                              Icon(
                                FeatherIcons.search,
                                color: Get.theme.colorScheme.primary,
                                size: 20,
                              ),
                              12.zw,
                              Expanded(
                                child: GestureDetector(
                                  onTap: logic.toSearch,
                                  child: AbsorbPointer(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        filled: false,
                                        enabled: false,
                                        constraints:
                                        BoxConstraints(maxHeight: 40),
                                        hintText: "Search for a recipe",
                                        contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                        isDense: true,
                                        border: InputBorder.none,
                                        hintStyle: Get.textTheme.bodyMedium!
                                            .copyWith(
                                            color: Get.theme.hintColor,
                                            height: 4.pxToDouble),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  }),
                  actions: [
                    IconButton(
                        padding: 0.p,
                        iconSize: 24,
                        constraints: BoxConstraints(),
                        onPressed: () {},
                        icon: Icon(FeatherIcons.bell,
                            color: Get.theme.primaryColor))
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          50.zh,
                          Row(
                            children: [
                              Text(
                                "Hello, ",
                                style: Get.textTheme.labelLarge!.copyWith(
                                    letterSpacing: 2,
                                    color: Get.theme.dividerColor
                                        .withValues(alpha: .6)),
                              ),
                              Obx(() {
                                return Text(
                                  "${logic.getUser?.displayName}!",
                                  style: Get.textTheme.labelLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 2,
                                      color: Get.theme.primaryColor),
                                );
                              }),
                            ],
                          ),
                          6.zh,
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              "Make your own food,\nstay at home",
                              style: Get.textTheme.headlineLarge!.copyWith(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                height: 18.pxToDouble,
                              ),
                            ),
                          ),
                          24.zh,
                          Container(
                            decoration: BoxDecoration(
                              color: Get.theme.colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Icon(
                                  FeatherIcons.search,
                                  color: Get.theme.colorScheme.primary,
                                  size: 20,
                                ),
                                16.zw,
                                Expanded(
                                  child: GestureDetector(
                                    onTap: logic.toSearch,
                                    child: AbsorbPointer(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          filled: false,
                                          hintText: "Search for a recipe",
                                          border: InputBorder.none,
                                          hintStyle: Get.textTheme.bodyMedium!
                                              .copyWith(
                                              color: Get.theme.hintColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ];
            },
            physics: AlwaysScrollableScrollPhysics(),
            controller: state.scrollController.value,
            // dragStartBehavior: DragStartBehavior.down,
            body: Obx(() {
              return Visibility(
                visible: state.isRefresh.value && state.listData.isEmpty,
                replacement: RefreshIndicator(
                  onRefresh: logic.refreshLoader,
                  child: ListView(
                    padding: 0.p,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Obx(() {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: 16.p,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 3 / 5,
                          ),
                          itemCount: state.listData.length,
                          itemBuilder: (BuildContext context, int i) {
                            final item = state.listData[i];
                            return RecipesWidgets(item: item);
                          },
                        );
                      }),
                      16.zh,
                      Obx(() {
                        return Visibility(
                            visible: state.loadingMore.value,
                            child: SizedBox(
                              height: 100,
                              child:
                              const Center(child: CircularProgressIndicator()),
                            ));
                      }),
                    ],
                  ),
                ),
                child: Center(child: CircularProgressIndicator(),),
              );
            })),
      ),
    );
  }
}
