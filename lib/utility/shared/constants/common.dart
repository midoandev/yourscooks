import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:get/get.dart';

class Common {
  static FontWeight light = FontWeight.w300;
  static FontWeight medium = FontWeight.w400;
  static FontWeight regular = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;

  static bool get isLandscape => Get.width > Get.height;
}

String getRandomNumber() {
  Random random = Random();
  int randomNumber = random.nextInt(10000000);
  int lngt = randomNumber.toString().length;
  String myNumber = randomNumber.toString().substring(0, lngt > 5 ? 5 : lngt);
  return myNumber;
}

bool isJsonString(value) {
  try {
    jsonDecode(value);
  } catch (e) {
    return false;
  }
  return true;
}

