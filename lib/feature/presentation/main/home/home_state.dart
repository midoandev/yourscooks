import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../domain/entities/recipes.dart';

class HomeState {
  var isRefresh = false.obs;
  var listData = <Recipes>[].obs;

  var lastKey = Rxn<DocumentSnapshot>();
  var hasMore = true.obs;
  var scrollController = ScrollController();
  var loadingMore = false.obs;
  var listFavorite = <int>[].obs;

  var isSliverScroll = false.obs;
}
