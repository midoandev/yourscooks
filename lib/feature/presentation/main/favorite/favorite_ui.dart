import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'favorite_logic.dart';
import 'favorite_state.dart';

class FavoriteUi extends StatelessWidget {
  FavoriteUi({super.key});
  final FavoriteLogic logic = Get.put(FavoriteLogic());
  final FavoriteState state = Get.find<FavoriteLogic>().state;

  @override
  Widget build(BuildContext context) {

    return Container();
  }
}
