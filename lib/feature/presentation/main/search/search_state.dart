import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/recipes.dart';

class SearchState {
  var isRefresh = false.obs;
  var listData = <Recipes>[].obs;
  var searchText = ''.obs;

  var scrollController = ScrollController();

  var loadingMore = false.obs;

}
