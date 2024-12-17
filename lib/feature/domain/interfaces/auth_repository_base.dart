import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yourscooks/feature/domain/entities/recipes.dart';

abstract class AuthRepositoryBase {
  Future<Either<dynamic, Unit>> signWithGoogle();
  Either<dynamic, User> getUser();
}
