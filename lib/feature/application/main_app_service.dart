import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/domain/entities/recipes_data.dart';

import '../../utility/shared/services/storage_service.dart';
import '../domain/interfaces/main_repository_base.dart';
import '../infrastructure/repository/main_repository.dart';

class MainAppService {
  final MainRepositoryBase _repository = Get.find<MainRepository>();

  Future<Either<dynamic, RecipesData>> getRecipes({String? keyword, dynamic lastKey}) async {
    return await _repository.getRecipes(keyword: keyword, lastKey: lastKey);
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
