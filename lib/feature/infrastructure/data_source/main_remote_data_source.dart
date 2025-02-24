import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:yourscooks/utility/shared/utils/string_helper.dart';

import '../../../utility/network/api_provider.dart';
import '../../domain/entities/recipes.dart';
import '../models/recipes_response.dart';

class MainRemoteDataSource {
  final _api = Get.find<ApiProvider>();

  Map<String, dynamic> convertToMapStringDynamic(Map<Object?, Object?> input) {
    return input.map((key, value) {
      if (key is String) {
        return MapEntry(key, value);
      } else {
        throw Exception("Key is not a String: $key");
      }
    });
  }

  Future<Either<dynamic, List<QueryDocumentSnapshot<Object?>>>> getRecipes(
      {dynamic lastDocument, String? keyword}) async {
    var query = _api.recipesDb
        .orderBy('RecipeId')
        // .where('Images', isNotEqualTo: 'character(0)')
        .limit(10);

    if (keyword != null) {
      final listKeyword = keyword.split(' ');
      final capitalKeywords =
          listKeyword.map((e) => e.capitalizeFirstofEach).toList();
      List<String> fixKeyword = [...listKeyword, ...capitalKeywords];
      Get.log('sdlfmdlkmf $fixKeyword');
      query = _api.recipesDb
          .where(
            'Keywords',
            arrayContainsAny: fixKeyword,
          )
          .limit(10);
    }
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    try {
      final QuerySnapshot res = await query.get();
      Get.log('dlfmslkamf ${res.docs.length}');
      if (res.docs.isEmpty) return Right([]);
      Get.log('dlfmslkamf ${res.docs.length}');
      // Get.log(
      //     'ioujiouio ${res.docs.runtimeType} isListObject=${(res.docs.runtimeType == List<Object?>)}');
      // var valueList = res.docs.map((e) => e.data() as Map<String, dynamic>);
      // var newList = valueList.map((e) => RecipesResponse.fromJson(e)).toList();
      return Right(res.docs);
    } catch (e) {
      Get.log('dlfmslkamf $e');

      return Left(e);
    }
  }

  Future<Either<dynamic, List<QueryDocumentSnapshot<Object?>>>> getReviews(
      {required String recipeId,
      DocumentSnapshot<Object?>? lastDocument}) async {
    var query = _api.recipesDb.where('recipeId', isEqualTo: recipeId).limit(10);
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    try {
      final QuerySnapshot res = await query.get();
      Get.log('reviese ${res.docs.length}');
      if (res.docs.isEmpty) return Right([]);
      // Get.log(
      //     'ioujiouio ${res.docs.runtimeType} isListObject=${(res.docs.runtimeType == List<Object?>)}');
      // var valueList = res.docs.map((e) => e.data() as Map<String, dynamic>);
      // var newList = valueList.map((e) => RecipesResponse.fromJson(e)).toList();
      return Right(res.docs);
    } catch (e) {
      Get.log('reviese $e');

      return Left(e);
    }
  }

  Future<Either<dynamic, bool>> isFavorite(
      {required int idRecipes, required String userId}) async {
    try {
      // final userRef = _api.favoriteDb.where(userId);
      final reqFavorites =
          await _api.favoriteDb.doc(userId).collection(userId).get();
      Get.log('isFavorite ${reqFavorites.docs.isNotEmpty}');
      if (reqFavorites.docs.isNotEmpty) {
        var valueList = reqFavorites.docs.map((e) => e.data());
        // var valueList = reqFavorites.data() as Map<String, dynamic>;
        var data = valueList.map((e) => RecipesResponse.fromJson(e)).toList();
        final isExist =
            data.any((element) => element.recipeId == idRecipes);
        if (isExist) {}
      }
      return Right(false);
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<dynamic, Unit>> setFavorite(
      {required Recipes recipeObject, required String userId}) async {
    // final userId = 'kjsdnjf324';
    try {
      final reqFavorites =
          await _api.favoriteDb.orderBy(userId).get();
      // Get.log('dslfmlkdsm ${reqFavorites.docs.length}');
      if (reqFavorites.docs.isNotEmpty) {

        final dataDocs = reqFavorites.docs.map((e) => e.data() as Map<String, dynamic>);
        var valueList = dataDocs.first.values.first as List;
        var data = valueList.map((e) => RecipesResponse.fromJson(e)).toList();

        Get.log('dslfmlkdsm ${data.map((e) => e.name)}');
        final isExist =
            data.any((element) => element.recipeId == recipeObject.recipeId);
        if (isExist) {
          final newList =
              data.where((element) => element.recipeId != recipeObject.recipeId);
          // Get.log('dslfmlkdsmfsdf ${newList.map((e) => e.name)}');
          await _api.favoriteDb.doc(userId).update({userId: newList.map((e) => e.toJson())});
        } else {
          await _api.favoriteDb.doc(userId).set({
            userId: FieldValue.arrayUnion([recipeObject.toJson()])
          }, SetOptions(merge: true));
        }
        return Right(unit);
      }
      await _api.favoriteDb.doc(userId).set({
        userId: FieldValue.arrayUnion([recipeObject.toJson()])
      }, SetOptions(merge: true));
      return Right(unit);
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<dynamic, List<RecipesResponse>>> getFavorites(
      {required String userId}) async {
    Get.log('userID $userId');
    var query = _api.favoriteDb.orderBy(userId).limit(25);
    try {
      final QuerySnapshot res = await query.get();
      Get.log('favorites ${res.docs}');
      if (res.docs.isEmpty) return Right([]);
      final dataDocs = res.docs.map((e) => e.data() as Map<String, dynamic>);
      var valueList = dataDocs.first.values.first as List;
      var newList = valueList.map((e) => RecipesResponse.fromJson(e)).toList();
      return Right(newList);
    } catch (e) {
      Get.log('reviese $e');
      return Left(e);
    }
  }
}
