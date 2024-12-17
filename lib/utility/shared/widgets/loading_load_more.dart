import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourscooks/utility/shared/utils/number_helper.dart';

class LoadingLoadMore extends StatelessWidget {
  const LoadingLoadMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      margin: 12.p,
      child: Platform.isIOS
          ? CupertinoActivityIndicator(
              color: Get.theme.primaryColor,
              radius: 10,
            )
          : Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Get.theme.primaryColor,
              ),
            ),
    );
  }
}
