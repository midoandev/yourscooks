import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search_logic.dart';
import 'search_state.dart';

class SearchUi extends StatelessWidget {
  SearchUi({super.key});
  final SearchLogic logic = Get.put(SearchLogic());
  final SearchState state = Get.find<SearchLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
