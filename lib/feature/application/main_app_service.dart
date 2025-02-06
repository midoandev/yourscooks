import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/domain/entities/recipes.dart';

import '../../utility/shared/services/storage_service.dart';
import '../domain/interfaces/main_repository_base.dart';
import '../infrastructure/repository/main_repository.dart';

class MainAppService {
  final MainRepositoryBase _repository = Get.find<MainRepository>();

  Future<Either<dynamic, List<Recipes>>> getRecipes({String? lastKey}) async {
    return await _repository.getRecipes(lastKey: lastKey);
  }
  Future<Either<dynamic, List<Recipes>>> searchRecipes(String keyword) async {
    return await _repository.searchRecipes(keyword);
  }

  Future<Either<dynamic, Unit>> setFavorite(
      {required int idRecipes, required String userId}) async {
    final res =
        await _repository.setFavorite(idRecipes: idRecipes, userId: userId);
    return res.fold((l) => Left(l), (r) => Right(unit));
  }

  Future<Either<dynamic, bool>> isFavorite(
      {required int idRecipes, required String userId}) async {
    final res =
        await _repository.isFavorite(idRecipes: idRecipes, userId: userId);
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  Future<void> changeTheme(bool isDark) async {
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light );
    await StorageService.setPrefBool(key: StorageEnum.themeIsDark, value: isDark);
    await Get.forceAppUpdate();
  }
}
