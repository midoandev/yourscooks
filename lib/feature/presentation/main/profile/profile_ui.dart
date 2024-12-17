import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yourscooks/utility/shared/utils/number_helper.dart';
import 'package:yourscooks/utility/shared/widgets/header_widget/custom_switch.dart';

import 'profile_logic.dart';
import 'profile_state.dart';

class ProfileUi extends StatelessWidget {
  ProfileUi({super.key});

  final ProfileLogic logic = Get.put(ProfileLogic());
  final ProfileState state = Get
      .find<ProfileLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: 24.p,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info
              Row(
                children: [
                  // Profile Picture
                  Obx(() {
                    return Visibility(
                      visible: state.userProfile.value?.photoURL != null,
                      replacement: Icon(FeatherIcons.user),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            state.userProfile.value?.photoURL ?? ''),
                      ),
                    );
                  }),
                  16.zw,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.userProfile.value?.displayName ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.headlineSmall),
                      Text(state.userProfile.value?.email ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
              16.zh,

              Divider(),
              24.zh,

              menuItem(
                icon: FeatherIcons.settings,
                title: "Your Account",
                onTap: () {
                  // Action for Account Settings
                },
              ),
              16.zh,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        FeatherIcons.moon,
                        // color: Get.theme.colorScheme.,
                      ),
                      SizedBox(width: 16),
                      Text('Dark Mode', style: Get.textTheme.titleMedium),
                    ],
                  ),
                  Obx(() {
                    return Switch(
                        value: state.isDarkMode.value,
                        onChanged: logic.changeTheme);
                  }),
                ],
              ),
              16.zh,

              menuItem(
                icon: FeatherIcons.helpCircle,
                title: "Help",
                onTap: () {
                  // Action for Logout
                },
              ),
              16.zh,
              menuItem(
                icon: FeatherIcons.logOut,
                title: "Logout",
                colorIcon: Get.theme.colorScheme.error,
                colorText: Get.theme.colorScheme.error,
                onTap: () {
                  // Action for Logout
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuItem({required IconData icon,
    required String title,
    Color? colorIcon,
    Color? colorText,
    required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: colorIcon,
              size: 24,
            ),
            16.zw,
            Text(title,
                style: Get.textTheme.titleMedium?.copyWith(color: colorText)),
          ],
        ),
      ),
    );
  }
}
