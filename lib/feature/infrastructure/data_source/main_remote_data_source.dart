import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yourscooks/utility/shared/utils/string_helper.dart';

import '../../../core/env.dart';
import '../../../utility/network/api_provider.dart';

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

  Future<Either<dynamic, List<QueryDocumentSnapshot<Object?>>>> getRecipes(
      {dynamic lastDocument, String? keyword}) async {
    var query = _api.recipesDb
        .orderBy('RecipeId')
        // .where('Images', isNotEqualTo: 'character(0)')
        .limit(10);

    if (keyword != null) {
      final listKeyword = keyword.split(' ');
      final capitalKeywords = listKeyword.map((e) => e.capitalizeFirstofEach).toList();
      List<String> fixKeyword = [...listKeyword, ...capitalKeywords];
      Get.log('sdlfmdlkmf $fixKeyword');
      query = _api.recipesDb
          .where(
            'Keywords',
            arrayContainsAny: fixKeyword,
          )
          .limit(10);
    }
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    try {
      final QuerySnapshot res = await query.get();
      Get.log('dlfmslkamf ${res.docs.length}');
      if (res.docs.isEmpty) return Right([]);
      Get.log('dlfmslkamf ${res.docs.length}');
      // Get.log(
      //     'ioujiouio ${res.docs.runtimeType} isListObject=${(res.docs.runtimeType == List<Object?>)}');
      // var valueList = res.docs.map((e) => e.data() as Map<String, dynamic>);
      // var newList = valueList.map((e) => RecipesResponse.fromJson(e)).toList();
      return Right(res.docs);
    } catch (e) {
      Get.log('dlfmslkamf ${e}');

      return Left(e);
    }
  }

  Future<Either<dynamic, bool>> isFavorite(
      {required int idRecipes, required String userId}) async {
    try {
      final userRef = _api.favoriteDb.where(userId);
      final snapshot = await userRef.get();
      if (snapshot.docs.isEmpty) return Left("Not found");
      List<dynamic> favorites = List.from(snapshot.docs as List);
      return Right(favorites.contains(idRecipes));
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<dynamic, Unit>> setFavorite(
      {required int idRecipes, required String userId}) async {
    try {
      final userRef = _api.favoriteDb.where(userId);
      final snapshot = await userRef.get();

      if (snapshot.docs.isEmpty) {
        // final list = [idRecipes];
        // await userRef.;
        return Right(unit);
      }

      List<dynamic> favorites = List.from(snapshot.docs as List);
      print("Value currentFavorites: $favorites");
      if (favorites.contains(idRecipes)) {
        favorites.remove(idRecipes);
        // await userRef.set(favorites);
        print("Value removed successfully.");
      } else {
        favorites.add(idRecipes);
        // await userRef.set(favorites);
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

  Future<Either<dynamic, List<QueryDocumentSnapshot<Object?>>>> searchRecipes(
      {required String keyword, DocumentSnapshot? lastDocument}) async {
    // Query query = _api.recipesDb.orderByKey().limitToFirst(10);
    final req = await _api.recipesDb
        .where('Name', arrayContains: "$keyword\uf8ff")
        .limit(10)
        .get();

    var query =
        _api.recipesDb.where('Images', isNotEqualTo: "character(0)").limit(10);

    if (lastDocument != null) {
      query = _api.recipesDb.startAfterDocument(lastDocument);
    }

    try {
      final QuerySnapshot res = await query.get();
      if (res.docs.isEmpty) return Right([]);
      return Right([]);
    } catch (e) {
      return Left(e);
    }
  }
}
