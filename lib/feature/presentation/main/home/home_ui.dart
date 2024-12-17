import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/domain/entities/recipes.dart';
import 'package:yourscooks/feature/domain/entities/recipes_ext.dart';
import 'package:yourscooks/utility/shared/utils/number_helper.dart';
import 'package:yourscooks/utility/shared/widgets/loading_load_more.dart';

import '../../../../utility/generate/assets.gen.dart';
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
    return sliverWidget();
    // return Scaffold(
    //     body: SafeArea(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Expanded(child: Obx(() {
    //             return Visibility(
    //               visible: state.listData.isNotEmpty,
    //               replacement: Center(
    //                 child: Text(
    //                   'Not found',
    //                 ),
    //               ),
    //               child: Obx(() {
    //                 return LoadMoreListView.builder(
    //                     padding: EdgeInsets.symmetric(horizontal: 20)
    //                         .copyWith(bottom: 16),
    //                     hasMoreItem: state.hasMore.value,
    //                     onLoadMore: logic.loadMore,
    //                     onRefresh: logic.refreshLoader,
    //                     loadMoreWidget: LoadingLoadMore(),
    //                     itemCount: state.listData.length,
    //                     itemBuilder: (BuildContext context, int index) {
    //                       final item = state.listData[index];
    //                       return productListTile(item);
    //                     });
    //               }),
    //             );
    //           })),
    //           // Obx(() {
    //           //   return Text('haha ${state.listData.value.last.toJson()}');
    //           // }),
    //         ],
    //       ),
    //     ));
  }

  Widget productListTile(Recipes item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: 7.5.circularRadius,
                  ),
                  child: item.imagesFirst.isEmpty
                      ? AppImages.vector.appIcon.image()
                      : ClipRRect(
                      borderRadius: 10.circularRadius,
                      child: Image.network(
                        item.imagesFirst,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Positioned(
                  left: 10,
                  top: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: 7.5.circularRadius,
                        color: Get.theme.primaryColorLight.withOpacity(.5)),
                    child: Row(
                      children: [
                        Icon(
                          FeatherIcons.clock,
                          color: Colors.white.withOpacity(.7),
                          size: 10,
                        ),
                        6.zw,
                        Text(
                          item.totalTimeCook ?? '',
                          style: Get.textTheme.labelSmall?.copyWith(
                              color: Colors.white.withOpacity(.7), fontSize: 9),
                        ),
                      ],
                    ),
                  )),
              Positioned(
                  right: 4,
                  top: 4,
                  child: GestureDetector(
                    onTap: () => logic.toggleFavorite(item.recipeId),
                    child: Container(
                      padding: 8.p,
                      decoration: BoxDecoration(
                          borderRadius: 100.circularRadius,
                          color: Get.theme.primaryColorLight.withOpacity(.1)),
                      child: Row(
                        children: [
                          Obx(() {
                            return Icon(
                              Icons.favorite_outlined,
                              color: (state.listFavorite.contains(item.recipeId)
                                  ? Colors.amberAccent
                                  : Colors.grey),
                              size: 20,
                            );
                          })
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: 7.5.circularRadius,
                        color: Get.theme.primaryColorDark.withOpacity(.8)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellowAccent.withOpacity(.8),
                          size: 10,
                        ),
                        3.zw,
                        Text(
                          item.formatRating,
                          style: Get.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withOpacity(.8)),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
        12.zh,
        Text(
          item.name ?? '_',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: Get.textTheme.bodyLarge,
        ),
        3.zh,
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            item.recipeCategory ?? '--',
            style: Get.textTheme.bodySmall,
          ),
        )
      ],
    );
  }

  Widget sliverWidget() {
    return SafeArea(
      top: false,
      child: RefreshIndicator(
        onRefresh: logic.refreshLoader,
        child: CustomScrollView(
          dragStartBehavior: DragStartBehavior.down,
          controller: state.scrollController,
          slivers: [
            SliverAppBar(
              onStretchTrigger: () {
                state.isSliverScroll.value = true;
                return Future<void>.value();
              },
              expandedHeight: 185.0,
              pinned: true,
              title: Obx(() {
                return Visibility(
                    visible: state.isSliverScroll.value,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: 16.ph,
                      child: Row(
                        children: [
                          Icon(
                            FeatherIcons.search,
                            color: Get.theme.primaryColor,
                            size: 20,
                          ),
                          12.zw,
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                filled: false,
                                constraints: BoxConstraints(maxHeight: 40),
                                hintText: "Search for a recipe",
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 0),
                                isDense: true,
                                border: InputBorder.none,
                                hintStyle: Get.textTheme.bodyMedium!.copyWith(
                                    color: Colors.grey, height: 4.pxToDouble),
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
                    icon:
                    Icon(FeatherIcons.bell, color: Get.theme.primaryColor))
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
                                color: Colors.black.withOpacity(.6)),
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
                            color: Colors.black,
                          ),
                        ),
                      ),
                      24.zh,
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Icon(
                              FeatherIcons.search,
                              color: Get.theme.primaryColor,
                              size: 20,
                            ),
                            16.zw,
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: false,
                                  hintText: "Search for a recipe",
                                  border: InputBorder.none,
                                  hintStyle: Get.textTheme.bodyMedium!
                                      .copyWith(color: Colors.grey),
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
            ),
            Obx(() {
              return SliverPadding(
                padding: 16.p,
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 3 / 5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final item = state.listData[index];
                      return productListTile(item);
                    },
                    childCount: state.listData.length, // Number of grid items
                  ),
                ),
              );
            }),
            SliverToBoxAdapter(
              child: Obx(() {
                return Visibility(
                  visible: state.loadingMore.value,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: LoadingLoadMore()),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
