import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yourscooks/utility/shared/constants/constants.dart';

import '../../../core/env.dart';
import '../../../utility/network/api_provider.dart';
import '../models/recipes_response.dart';

class MainRemoteDataSource {
  final _api = Get.find<ApiProvider>();

  Map<String, dynamic> convertToMapStringDynamic(Map<Object?, Object?> input) {
    return input.map((key, value) {
      if (key is String) {
        return MapEntry(key, value);
      } else {
        throw Exception("Key is not a String: $key");
      }
    });
  }

  Future<Either<dynamic, List<RecipesResponse>>> getRecipes(
      {String? lastKey}) async {
    Query query = _api.recipesDb.orderByKey().limitToFirst(10);
    // Query query = _api.recipesDb
    //     .orderByChild('Name')
    //     .startAt('beef')
    //     .endAt("beef\uf8ff").limitToFirst(10);
    Get.log('lastKeyasdfs ${lastKey}');

    if (lastKey != null) {
      query = query.startAfter(lastKey);
    }

    try {
      final res = await query.get();
      if (!res.exists) return Right([]);
      Get.log(
          'ioujiouio ${res.value.runtimeType} isListObject=${(res.value.runtimeType == List<Object?>)}');

      var valueList = (res.value.runtimeType == List<Object?>)
          ? res.value as List<Object?>
          : (res.value as Map<Object?, Object?>).values.toList();
      List<Map<String, dynamic>> snap = valueList
          .map((e) => Map<String, dynamic>.from(e as Map<Object?, Object?>))
          .toList();
      var newList = snap.map((e) => RecipesResponse.fromJson(e)).toList();
      // final filter = newList.where((e) => e.images != 'character(0)');
      return Right(newList);
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<dynamic, bool>> isFavorite(
      {required int idRecipes, required String userId}) async {
    try {
      final userRef = _api.favoriteDb.child(userId);
      final snapshot = await userRef.get();
      if (!snapshot.exists) return Left("Not found");
      List<dynamic> favorites = List.from(snapshot.value as List);
      return Right(favorites.contains(idRecipes));
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<dynamic, Unit>> setFavorite(
      {required int idRecipes, required String userId}) async {
    try {
      final userRef = _api.favoriteDb.child(userId);
      final snapshot = await userRef.get();

      if (snapshot.value == null) {
        final list = [idRecipes];
        await userRef.set(list);
        return Right(unit);
      }

      List<dynamic> favorites = List.from(snapshot.value as List);
      print("Value currentFavorites: $favorites");
      if (favorites.contains(idRecipes)) {
        favorites.remove(idRecipes);
        await userRef.set(favorites);
        print("Value removed successfully.");
      } else {
        favorites.add(idRecipes);
        await userRef.set(favorites);
        print("Value not found in the array.");
      }

      return Right(unit);
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<dynamic, UserCredential>> signWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn(
        clientId: Env.value.clientIdIdIos,
      ).signIn();
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


  Future<Either<dynamic, List<RecipesResponse>>> searchRecipes(String keyword) async {
    // Query query = _api.recipesDb.orderByKey().limitToFirst(10);
    final req = await _api.recipesDb
        .orderByChild('Name')
        .equalTo("$keyword\uf8ff").limitToFirst(10).once();
    try {
      final res = req.snapshot;
      Get.log(
          'ioujiouio ${res.value.runtimeType} isListObject=${(res.value.runtimeType == List<Object?>)}');

      if (!res.exists) return Right([]);
      // Get.log(
      //     'ioujiouio ${res.value.runtimeType} isListObject=${(res.value.runtimeType == List<Object?>)}');
      //
      // var valueList = (res.value.runtimeType == List<Object?>)
      //     ? res.value as List<Object?>
      //     : (res.value as Map<Object?, Object?>).values.toList();
      // List<Map<String, dynamic>> snap = valueList
      //     .map((e) => Map<String, dynamic>.from(e as Map<Object?, Object?>))
      //     .toList();
      // var newList = snap.map((e) => RecipesResponse.fromJson(e)).toList();
      // // final filter = newList.where((e) => e.images != 'character(0)');
      return Right([]);
    } catch (e) {
      return Left(e);
    }
  }
}
