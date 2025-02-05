import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
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
  Future<Either<dynamic, Unit>> signWithApple() async {
    final res = await remote.signWithApple(
        rawNonce: generateNonce(), nonce: sha256ofString(generateNonce()));
    return res.fold((l) => Left(l), (r) => Right(unit));
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Either<dynamic, User> getUser() {
    final res = remote.getUser();
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<dynamic, Unit>> signOut() async {
    final res = await remote.signOut();
    return res.fold((l) => Left(l), (r) => Right(r));
  }
}
