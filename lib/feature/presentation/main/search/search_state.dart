import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/recipes.dart';

class SearchState {
  var isRefresh = false.obs;
  var listData = <Recipes>[].obs;
  var searchText = ''.obs;


  var loadingMore = false.obs;

  var lastKey = Rxn<DocumentSnapshot>();

  var hasMore = true.obs;

}
