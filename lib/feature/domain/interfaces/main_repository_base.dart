import 'package:dartz/dartz.dart';
import 'package:yourscooks/feature/domain/entities/recipes.dart';

abstract class MainRepositoryBase {
  Future<Either<dynamic, List<Recipes>>> getRecipes({String? lastKey});

  Future<Either<dynamic, Unit>> setFavorite(
      {required int idRecipes, required String userId});
  Future<Either<dynamic, bool>> isFavorite(
      {required int idRecipes, required String userId});

}
