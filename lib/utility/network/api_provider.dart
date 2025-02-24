import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiProvider {
  static final ApiProvider _instance = ApiProvider._internal();

  factory ApiProvider() {
    return _instance;
  }

  static const pathRecipes = 'recipes';
  static const pathReviews = 'reviews';
  static const pathFavorite = 'favorites';
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CollectionReference recipesDb = FirebaseFirestore.instance.collection(pathRecipes);
  CollectionReference reviewsDb = FirebaseFirestore.instance.collection(pathReviews);
  CollectionReference favoriteDb = FirebaseFirestore.instance.collection(pathFavorite);
  CollectionReference favoriteSubDb = FirebaseFirestore.instance.collection(pathFavorite);

  // DatabaseReference recipesDb = FirebaseDatabase.instance.ref().child(pathRecipes);
  // DatabaseReference favoriteDb = FirebaseDatabase.instance.ref().child(pathFavorite);

  // Future<void> createData(Guests data, {Function(Guests)? callGuest}) async {
  //   DatabaseReference newReference = _database.child(path).push();
  //
  //   String key = newReference
  //       .key!; // Mengambil kunci menggunakan property 'key' dari referensi baru
  //   data.id = key;
  //
  //   if (!await checkDataExist(data.name)) {
  //     await newReference.set(data.toJson()).whenComplete(() => callGuest!(data));
  //   }
  // }
  //
  // Future<Guests?> getGuestData(String nameFull) async {
  //   var value = await _database.child(path).once();
  //   if (value.snapshot.value == null) return null;
  //   var snapshot = value.snapshot.value as Map<String, dynamic>;
  //   var data = snapshot.entries.map((e) => e.value as Map<String, dynamic>).toList();
  //   var map = convertMapListToModelList(data);
  //   var selectList = map.where((element) => element.name == nameFull).toList();
  //   if (selectList.isNotEmpty){
  //     // print('selectList ${selectList.first.toJson()}');
  //     return selectList.first;
  //   }
  //   return null;
  // }
  //
  // updateFromName(Guests guests) async{
  //   var dataExist = await getGuestData(guests.name);
  //   guests.id = dataExist!.id;
  //   await updateData(guests);
  // }
  //
  // Future<bool> checkDataExist(String nameFull) async {
  //   var value = await _database.child(path).once();
  //   if (value.snapshot.value == null) return false;
  //   var snapshot = value.snapshot.value as Map<String, dynamic>;
  //   var check =
  //   snapshot.entries.any((element) {
  //     var ckNotGroup = element.value['name'] == nameFull;
  //     // var ckIsGroup = element.value['name_group'] == nameFull;
  //     return ckNotGroup;
  //   });
  //   // print('sdf $nameFull - ${check ? 'sudah ada' : 'belum ada'}');
  //   return check;
  // }
  //
  // Future<List<Guests>> readListGuest() async {
  //   final value = await _database.child(path).once();
  //   if (value.snapshot.value == null) return [];
  //   var snapshot = value.snapshot.value as Map<String, dynamic>;
  //   var data =
  //   snapshot.entries.map((e) => e.value as Map<String, dynamic>).toList();
  //   var map = convertMapListToModelList(data);
  //   // print('sdafd ${data.runtimeType}');
  //   // print('sdafd ${map.runtimeType}');
  //   return map;
  // }
  //
  // Future<List<String>> readSuggestGroup() async {
  //   var list = await readListGuest();
  //   var listNameGroup = <String>[];
  //   for (Guests guests in list){
  //     if (guests.nameGroup.isNotEmpty){
  //       if (!listNameGroup.contains(guests.nameGroup)){
  //         listNameGroup.add(guests.nameGroup);
  //       }
  //     }
  //   }
  //
  //   listNameGroup.sort((a, b) => a.compareTo(b));
  //   return listNameGroup;
  // }
  //
  // List<Guests> convertMapListToModelList(List<Map<String, dynamic>> mapList) {
  //   return mapList.map((map) => Guests.fromJson(map)).toList();
  // }
  //
  // Future<void> updateData(Guests guests) async {
  //   await _database.child(path).child(guests.id).update(guests.toJson());
  // }
  //
  // Future<void> deleteData(Guests guests) async {
  //   await _database.child(path).child(guests.id).remove();
  // }

  ApiProvider._internal();
}
