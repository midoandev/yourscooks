import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/domain/entities/recipes.dart';
import 'package:yourscooks/feature/domain/entities/reviews_data.dart';

import '../../domain/entities/recipes_data.dart';
import '../../domain/entities/reviews.dart';
import '../../domain/interfaces/main_repository_base.dart';
import '../data_source/main_remote_data_source.dart';

class MainRepository implements MainRepositoryBase {
  final remote = Get.find<MainRemoteDataSource>();

  @override
  Future<Either<dynamic, RecipesData>> getRecipes(
      {String? keyword, DocumentSnapshot? lastKey}) async {
    @override
    final res =
        await remote.getRecipes(keyword: keyword, lastDocument: lastKey);
    return res.fold((l) => Left(l), (r) {
      if (r.isEmpty) return Right(RecipesData(recipes: []));
      var valueList = r.map((e) => e.data() as Map<String, dynamic>);
      // var newList = valueList.map((e) => RecipesResponse.fromJson(e)).toList();
      var data = valueList.map((e) => Recipes.fromJson(e)).toList();
      final result = RecipesData(recipes: data, lastDocument: r.last);
      return Right(result);
    });
  }

  @override
  Future<Either<dynamic, List<Recipes>>> getFavorites(
      {required String userId, DocumentSnapshot<Object?>? lastDocument}) async {
    final res = await remote.getFavorites(userId: userId);
    return res.fold((l) => Left(l), (r) {
      if (r.isEmpty) return Right(<Recipes>[]);
      // final dataMap = r.first.data() as Map<String, dynamic>;
      // Get.log('dflaskmfkl $dataMap');
      // var valueList = r.map((e) => e.data() as Map<String, dynamic>);
      // var newList = valueList.map((e) => RecipesResponse.fromJson(e)).toList();
      var data = r.map((e) => Recipes.fromJson(e.toJson())).toList();
      // final result = RecipesData(recipes: data, lastDocument: r.last);
      return Right(data);
    });
  }

  @override
  Future<Either<dynamic, ReviewsData>> getReviews(
      {required String recipeId, DocumentSnapshot? lastKey}) async {
    @override
    final res =
        await remote.getReviews(recipeId: recipeId, lastDocument: lastKey);
    return res.fold((l) => Left(l), (r) {
      if (r.isEmpty) return Right(ReviewsData(reviews: []));
      var valueList = r.map((e) => e.data() as Map<String, dynamic>);
      // var newList = valueList.map((e) => RecipesResponse.fromJson(e)).toList();
      var data = valueList.map((e) => Reviews.fromJson(e)).toList();
      final result = ReviewsData(reviews: data, lastDocument: r.last);
      return Right(result);
    });
  }

  @override
  Future<Either<dynamic, Unit>> setFavorite(
      {required Recipes recipeObject, required String userId}) async {
    final res =
        await remote.setFavorite(recipeObject: recipeObject, userId: userId);
    return res.fold((l) => Left(l), (r) => Right(unit));
  }

  @override
  Future<Either<dynamic, bool>> isFavorite(
      {required int idRecipes, required String userId}) async {
    final res = await remote.isFavorite(idRecipes: idRecipes, userId: userId);
    return res.fold((l) => Left(l), (r) => Right(r));
  }
}
