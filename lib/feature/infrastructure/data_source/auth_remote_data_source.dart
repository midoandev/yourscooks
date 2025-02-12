import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../utility/network/api_provider.dart';

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

  Future<Either<dynamic, Unit>> signOut() async {
    try {
      await _api.auth.signOut();
      return Right(unit);
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<dynamic, UserCredential>> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(
              loginResult.accessToken?.tokenString ?? '');

      final users =
          await _api.auth.signInWithCredential(facebookAuthCredential);
      return Right(users);
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<dynamic, UserCredential>> signWithApple(
      {required String rawNonce, required String nonce}) async {
    try {
      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      final users = await _api.auth.signInWithCredential(oauthCredential);
      return Right(users);
    } catch (e) {
      return Left(e);
    }
  }
}
