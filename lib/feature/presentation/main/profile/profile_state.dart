import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileState {

  ProfileState(){
    Get.log('isDark ${Get.isDarkMode}');
    isDarkMode.value = Get.isDarkMode;
  }
  var userProfile = Rxn<User>();

  var isDarkMode = false.obs;
}
