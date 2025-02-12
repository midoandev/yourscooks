import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/domain/entities/recipes.dart';
import 'package:yourscooks/feature/domain/entities/recipes_ext.dart';
import 'package:yourscooks/utility/shared/utils/number_helper.dart';

import '../../../../utility/generate/assets.gen.dart';
import '../detail_recipes/detail_recipes_ui.dart';

class RecipesWidgets extends StatelessWidget {
  final Recipes item;

  const RecipesWidgets({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(DetailRecipesUi.namePath, arguments: item);
      },
      child: Column(
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
                          color: Get.theme.primaryColorLight.withValues(alpha: .5)),
                      child: Row(
                        children: [
                          Icon(
                            FeatherIcons.clock,
                            color: Colors.white.withValues(alpha: .7),
                            size: 10,
                          ),
                          6.zw,
                          Text(
                            '${item.totalTimeCook} mins',
                            style: Get.textTheme.labelSmall?.copyWith(
                                color: Colors.white.withValues(alpha: .7),
                                fontSize: 9),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: 7.5.circularRadius,
                          color: Get.theme.primaryColorDark.withValues(alpha: .8)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellowAccent.withValues(alpha: .8),
                            size: 10,
                          ),
                          3.zw,
                          Text(
                            item.formatRating,
                            style: Get.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white..withValues(alpha: .8)),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          12.zh,
          Text(
            item.nameClean,
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
      ),
    );
  }
}
