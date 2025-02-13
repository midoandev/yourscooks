import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/presentation/main/widgets/recipes_widgets.dart';
import 'package:yourscooks/utility/shared/utils/number_helper.dart';

import '../../../../utility/shared/widgets/loading_load_more.dart';
import '../../../../utility/shared/widgets/loadmore_listview.dart';
import 'search_logic.dart';
import 'search_state.dart';

class SearchUi extends StatelessWidget {
  static const String namePath = '/search-recipes';

  SearchUi({super.key});

  final SearchLogic logic = Get.put(SearchLogic());
  final SearchState state = Get.find<SearchLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Obx(() {
          return LoadMoreListView.customScrollView(
            dragStartBehavior: DragStartBehavior.down,
            loadMoreWidget: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: LoadingLoadMore()),
            ),
            onLoadMore: logic.loadMore,
            onRefresh: logic.refreshLoader,
            refreshBackgroundColor: Get.theme.canvasColor,
            refreshColor: Get.theme.primaryColor,
            hasMoreItem: state.hasMore.value,
            slivers: [
              SliverAppBar(
                pinned: true,
                title: Container(
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
                        child: TextField(
                          autofocus: true,
                          onSubmitted: logic.searchProduct,
                          decoration: InputDecoration(
                            filled: false,
                            constraints: BoxConstraints(maxHeight: 40),
                            hintText: "Search for a recipe",
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            isDense: true,
                            border: InputBorder.none,
                            hintStyle: Get.textTheme.bodyMedium!.copyWith(
                                color: Get.theme.hintColor,
                                height: 4.pxToDouble),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                      padding: 0.p,
                      iconSize: 24,
                      constraints: BoxConstraints(),
                      onPressed: () {},
                      icon: Icon(FeatherIcons.bell,
                          color: Get.theme.primaryColor))
                ],
              ),
              SliverToBoxAdapter(child: Obx(() {
                return Visibility(
                    visible: state.searchText.value.isNotEmpty && state.isRefresh.value,
                    child: Padding(
                      padding: 16.p,
                      child: Center(child: LoadingLoadMore()),
                    ));
              })),
              SliverToBoxAdapter(child: Obx(() {
                return Visibility(
                    visible: state.listData.isEmpty && state.searchText.isNotEmpty,
                    child: Padding(
                      padding: 16.p,
                      child: Center(child: Text(
                        '${state.searchText.value} Not found',
                        style: Get.textTheme.bodySmall,
                      )),
                    ));
              })),
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
                          return RecipesWidgets(item: item);
                        },
                        childCount: state.listData.length,
                      ),
                    ));
              }),
            ],
          );
        }),
      ),
    );
  }
}
