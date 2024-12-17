import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:yourscooks/feature/domain/entities/recipes.dart';

import '../../domain/interfaces/auth_repository_base.dart';
import '../../domain/interfaces/main_repository_base.dart';
import '../data_source/auth_remote_data_source.dart';
import '../data_source/main_remote_data_source.dart';

class AuthRepository implements AuthRepositoryBase {
  final remote = Get.find<AuthRemoteDataSource>();

  @override
  Future<Either<dynamic, Unit>> signWithGoogle() async {
    final res = await remote.signWithGoogle();
    return res.fold((l) => Left(l), (r) => Right(unit));
  }

  @override
  Either<dynamic, User> getUser() {
    final res = remote.getUser();
    return res.fold((l) => Left(l), (r) => Right(r));
  }
}
