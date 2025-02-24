import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:yourscooks/feature/domain/entities/recipes_data.dart';

import '../entities/recipes.dart';
import '../entities/reviews_data.dart';

abstract class MainRepositoryBase {
  Future<Either<dynamic, RecipesData>> getRecipes(
      {String? keyword, DocumentSnapshot? lastKey});

  Future<Either<dynamic, List<Recipes>>> getFavorites({required String userId});

  Future<Either<dynamic, ReviewsData>> getReviews(
      {required String recipeId, DocumentSnapshot? lastKey});

  Future<Either<dynamic, Unit>> setFavorite(
      {required Recipes recipeObject, required String userId});

  Future<Either<dynamic, bool>> isFavorite(
      {required int idRecipes, required String userId});
}
