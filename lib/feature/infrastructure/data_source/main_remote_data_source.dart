import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      return Right(newList);
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<dynamic, Unit>> setFavorite({required int idRecipes}) async {
    try {
      final userFavoritesRef = _api.favoriteDb;
      final userRef = userFavoritesRef.child('anom');
      final snapshot = await userRef.once();
      List<dynamic> currentFavorites = [];

      if (snapshot.snapshot.exists) {
        currentFavorites = snapshot.snapshot.value as List<dynamic>;
      }

      if (currentFavorites.contains(idRecipes)) {
        // Hapus nilai jika sudah ada
        currentFavorites.remove(idRecipes);
        print("Value removed: $idRecipes");
      } else {
        // Tambahkan nilai jika belum ada
        currentFavorites.add(idRecipes);
        print("Value added: $idRecipes");
      }

      // Simpan data yang telah dimodifikasi
      await userRef.set(currentFavorites);
      return Right(unit);
    } catch (e) {
      return Left(e);
    }
  }

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
}
