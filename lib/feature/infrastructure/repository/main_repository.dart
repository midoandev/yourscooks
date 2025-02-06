import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/domain/entities/recipes.dart';

import '../../domain/interfaces/main_repository_base.dart';
import '../data_source/main_remote_data_source.dart';

class MainRepository implements MainRepositoryBase {
  final remote = Get.find<MainRemoteDataSource>();

  @override
  Future<Either<dynamic, List<Recipes>>> getRecipes({String? lastKey}) async {
    @override
    final res = await remote.getRecipes(lastKey: lastKey);
    return res.fold((l) => Left(l), (r) {
      var data = r.map((e) => Recipes.fromJson(e.toJson())).toList();
      return Right(data);
    });
  }

  @override
  Future<Either<dynamic, List<Recipes>>> searchRecipes(String keyword) async {
    @override
    final res = await remote.searchRecipes(keyword);
    return res.fold((l) => Left(l), (r) {
      var data = r.map((e) => Recipes.fromJson(e.toJson())).toList();
      return Right(data);
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
