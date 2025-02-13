import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/domain/entities/recipes_ext.dart';
import 'package:yourscooks/utility/shared/utils/number_helper.dart';
import 'package:yourscooks/utility/shared/utils/string_helper.dart';

import '../../../../utility/generate/assets.gen.dart';
import 'detail_recipes_logic.dart';

class DetailRecipesUi extends StatelessWidget {
  static const String namePath = '/detail-recipes';

  DetailRecipesUi({super.key});

  final logic = Get.put(DetailRecipesLogic());
  final state = Get
      .find<DetailRecipesLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableHome(
          leading: IconButton(
            onPressed: logic.backPress,
            icon: Icon(
              FeatherIcons.arrowLeft,
              color: Get.theme.primaryColor,
            ),
          ),
          actions: [
            IconButton(
                onPressed: logic.backPress,
                icon: Icon(
                  Icons.favorite_outlined,
                  color: Get.theme.primaryColor,
                  size: 20,
                )
            )
          ],
          title: SizedBox(),
          headerWidget: headerWidget(),
          body: [widgetBody()]),
    );
  }

  Widget headerWidget() {
    return Stack(
      children: [
        Obx(() {
          return Visibility(
            visible: (state.recipes.value?.images?.length ?? 0) > 0,
            replacement: SizedBox(
                height: 400,
                width: double.infinity,
                child: AppImages.vector.appIcon.image()),
            child: ImageSlideshow(
              width: double.infinity,
              height: 400,
              indicatorBottomPadding: 32,
              initialPage: 0,
              indicatorColor: Get.theme.primaryColor,
              indicatorBackgroundColor: Get.theme.colorScheme.onInverseSurface,
              autoPlayInterval: 3000,
              isLoop: (state.recipes.value?.images?.length ?? 0) > 1,
              children: state.recipes.value?.images?.map((stringUrl) {
                return Image.network(
                  stringUrl.removeQuoteChar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return AppImages.vector.appIcon.image();
                  },
                );
              }).toList() ??
                  [AppImages.vector.appIcon.image()],
            ),
          );
        }),
        // Top Icons
        Positioned(
          top: 40,
          left: 16,
          child: GestureDetector(
            onTap: logic.backPress,
            child: CircleAvatar(
              child: Icon(
                FeatherIcons.arrowLeft,
                color: Get.theme.primaryColor,
              ),
            ),
          ),
        ),
        Positioned(
          top: 40,
          right: 16,
          child: GestureDetector(
            onTap: logic.toggleFavorite,
            child: CircleAvatar(
                child: Obx(() {
                  return Icon(
                    Icons.favorite_outlined,
                    color: state.isFavorite.value
                        ? Get.theme.primaryColor
                        : Get.theme.disabledColor,
                    size: 20,
                  );
                })),
          ),
        ),
      ],
    );
  }

  Widget widgetBody() {
    return Container(
      padding: 16.p,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Text(
                        state.recipes.value?.nameClean ?? '',
                        style: Get.textTheme.bodyLarge?.copyWith(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                    4.zh,
                    Row(
                      children: [
                        Text(
                          'by',
                          style: Get.textTheme.bodyLarge?.copyWith(
                            fontSize: 14,
                            color: Get.theme.dividerColor.withOpacity(.6),
                          ),
                        ),
                        4.zw,
                        Obx(() {
                          return Text(
                            state.recipes.value?.authorName ?? '',
                            style: Get.textTheme.bodyLarge?.copyWith(
                              fontSize: 14,
                              color: Get.theme.primaryColorDark,
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              24.zw,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Get.theme.primaryColorDark.withOpacity(.8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 18),
                    SizedBox(width: 4),
                    Text(
                      state.recipes.value?.formatRating ?? '',
                      style: Get.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(.8)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.zh,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoCard(
                  icon: FeatherIcons.clock,
                  value: state.recipes.value?.timeCooking,
                  unit: 'mins'),
              _infoCard(
                  icon: Icons.timer,
                  value: state.recipes.value?.prepTimeCook,
                  unit: 'mins'),
              _infoCard(
                  icon: Icons.local_fire_department,
                  value: state.recipes.value?.calories.toString(),
                  unit: 'Cal'),
              _infoCard(
                  icon: FeatherIcons.users,
                  value: (state.recipes.value?.recipeServings ?? 1).toString(),
                  unit: 'servings'),
            ],
          ),
          16.zh,

          // Ingredients Section
          Text(
            'Overview',
            style: Get.textTheme.bodyLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          8.zh,
          Text(
            state.recipes.value?.description ?? '',
            style: Get.textTheme.bodyLarge,
          ),
          16.zh,

          // Ingredients Section
          Text(
            'Ingredients',
            style: Get.textTheme.bodyLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          8.zh,
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                state.recipes.value?.listIngredientParts.length ?? 0,
                    (index) {
                  final quantities =
                  state.recipes.value?.listIngredientQuantities[index];
                  final parts = state.recipes.value?.listIngredientParts[index];
                  return _textListItem('$quantities $parts');
                },
              ).toList()),
          16.zh,
          Text(
            'Directions',
            style: Get.textTheme.bodyLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          8.zh,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.recipes.value?.listInstruction.map(
                  (e) {
                return _textListItem(e);
              },
            ).toList() ??
                [],
          ),
        ],
      ),
    );
  }

  Widget _infoCard({required IconData icon, String? value, String? unit}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Get.theme.primaryColorDark.withValues(alpha: .7),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        8.zh,
        Text(
          value ?? '',
          style: Get.textTheme.bodyLarge?.copyWith(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          unit ?? '',
          style: Get.textTheme.bodyLarge
              ?.copyWith(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _textListItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.circle,
            size: 8, color: Get.theme.primaryColorDark.withOpacity(.8)),
        8.zw,
        Expanded(
          child: Text(
            text.trim(),
            style: Get.textTheme.bodyLarge
                ?.copyWith(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
