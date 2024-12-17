import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile_logic.dart';
import 'profile_state.dart';

class ProfileUi extends StatelessWidget {
  ProfileUi({super.key});
  final ProfileLogic logic = Get.put(ProfileLogic());
  final ProfileState state = Get.find<ProfileLogic>().state;

  @override
  Widget build(BuildContext context) {

    return Container();
  }
}
