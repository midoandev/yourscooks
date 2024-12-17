import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utility/network/api_provider.dart';
import '../models/recipes_response.dart';

class AuthRemoteDataSource {
  final _api = Get.find<ApiProvider>();

  Future<Either<dynamic, UserCredential>> signWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credit = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      final users = await _api.auth.signInWithCredential(credit);
      Get.log('aklsdmfkd ${users.user?.displayName} ${users.user?.photoURL}');
      return Right(users);
    } catch (e) {
      return Left(e);
    }
  }

  Either<dynamic, User> getUser() {
    User? user = _api.auth.currentUser;
    if (user == null) return Left(unit);
    return Right(user);
  }

  Future<Either<dynamic, Unit>> signOut() async{
    try {
      await _api.auth.signOut();
      return Right(unit);
    } catch (e) {
      return Left(e);
    }
  }
}
