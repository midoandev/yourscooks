import 'package:flutter/material.dart';

import 'leading_default.dart';

class AppBarCustomTitleDefault extends AppBar {
  AppBarCustomTitleDefault(
      {super.key,
      required Function() onBack,
      required Widget customTitle,
      bool withLeading = true,
      List<Widget>? actionListWidget,
      double? elevation})
      : super(
          title: customTitle,
          titleSpacing: 0,
          elevation: elevation ?? .5,
          centerTitle: false,
          automaticallyImplyLeading: withLeading,
          leading: withLeading == true ? LeadingDefault(onBack: onBack) : null,
          actions: actionListWidget,
        );
}
