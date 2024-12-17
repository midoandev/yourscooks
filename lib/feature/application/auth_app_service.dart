import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/domain/entities/recipes.dart';

import '../domain/interfaces/auth_repository_base.dart';
import '../domain/interfaces/main_repository_base.dart';
import '../infrastructure/repository/auth_repository.dart';
import '../infrastructure/repository/main_repository.dart';

class AuthAppService {
  final AuthRepositoryBase _repository = Get.find<AuthRepository>();

  Future<Either<dynamic, Unit>> signWithGoogle() async {
    final res = await _repository.signWithGoogle();
    return res.fold((l) => Left(l), (r) => Right(unit));
  }
  Either<dynamic, User> getUser() {
    final res = _repository.getUser();
    return res.fold((l) => Left(l), (r) => Right(r));
  }
}
