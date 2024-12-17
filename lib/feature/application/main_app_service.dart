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
    final res = await _repository.getRecipes(lastKey: lastKey);
    return res.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  Future<Either<dynamic, Unit>> setFavorite(
      {required int idRecipes, required String userId}) async {
    final res =
        await _repository.setFavorite(idRecipes: idRecipes, userId: userId);
    return res.fold((l) => Left(l), (r) => Right(unit));
  }

  Future<Either<dynamic, Unit>> signWithGoogle(
      {String? idToken, String? accessToken}) async {
    final res = await _repository.signWithGoogle();
    return res.fold((l) => Left(l), (r) => Right(unit));
  }


  Future<void> changeTheme(bool isDark) async {
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light );
    await StorageService.setPrefBool(key: StorageEnum.themeIsDark, value: isDark);
    await Get.forceAppUpdate();
  }
}
