import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/domain/entities/recipes.dart';

import '../../domain/entities/recipes_data.dart';
import '../../domain/interfaces/main_repository_base.dart';
import '../data_source/main_remote_data_source.dart';
import '../models/recipes_response.dart';

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
  Future<Either<dynamic, Unit>> setFavorite(
      {required int idRecipes, required String userId}) async {
    final res = await remote.setFavorite(idRecipes: idRecipes, userId: userId);
    return res.fold((l) => Left(l), (r) => Right(unit));
  }

  @override
  Future<Either<dynamic, bool>> isFavorite(
      {required int idRecipes, required String userId}) async {
    final res = await remote.isFavorite(idRecipes: idRecipes, userId: userId);
    return res.fold((l) => Left(l), (r) => Right(r));
  }
}
