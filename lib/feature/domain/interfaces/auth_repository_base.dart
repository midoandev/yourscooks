import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yourscooks/feature/domain/entities/recipes.dart';

abstract class AuthRepositoryBase {
  Future<Either<dynamic, Unit>> signWithGoogle();
  Future<Either<dynamic, Unit>> signWithApple();
  Either<dynamic, User> getUser();
  Future<Either<dynamic, Unit>> signOut();
}
