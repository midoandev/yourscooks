import 'package:flutter/material.dart';

import 'leading_default.dart';
import 'title_appbar_default.dart';

class AppBarDefault extends AppBar {
  AppBarDefault(
      {super.key,
      Function()? onBack,
      required String labelTitle,
      double? elevation,
      List<Widget>? actionListWidget})
      : super(
          title: TitleAppBarDefault(labelTitle: labelTitle),
          titleSpacing: 0,
          centerTitle: false,
          elevation: elevation ?? .4,
          leading: LeadingDefault(onBack: onBack),
          actions: actionListWidget,
        );
}
