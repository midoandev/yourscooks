import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourscooks/utility/shared/utils/number_helper.dart';

class CustomDialog {
  static void showMessageDialog(
    message, {
    String? title,
    String? positiveLabel,
    VoidCallback? positiveAction,
  }) {
    final Text titleText = Text(title ?? 'Information',
        style: Get.textTheme.headlineMedium?.copyWith(height: 24.pxToDouble));
    final Text messageText = Text(message,
        style: Get.textTheme.bodyLarge?.copyWith(height: 21.pxToDouble));
    final Text buttonText = Text(positiveLabel ?? 'Ok',
        style: Get.textTheme.bodyLarge
            ?.copyWith(color: Colors.black, height: 21.pxToDouble));

    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        if (Platform.isAndroid) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: titleText,
            content: messageText,
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  positiveAction?.call();
                },
                child: buttonText,
              ),
            ],
          );
        }

        return CupertinoAlertDialog(
          title: titleText,
          content: messageText,
          actions: [
            CupertinoDialogAction(
                isDestructiveAction: false,
                onPressed: () {
                  Get.back();
                  positiveAction?.call();
                },
                child: buttonText),
          ],
        );
      },
    );
  }

  static void showConfirmDialog(
    message, {
    String? title,
    String? positiveLabel,
    String? negativeLabel,
    VoidCallback? positiveAction,
    VoidCallback? negativeAction,
    ButtonStyle? positiveLabelStyle,
    ButtonStyle? negativeLabelStyle,
  }) async {
    final Text titleText = Text(title ?? 'Information',
        style: Get.textTheme.headlineMedium?.copyWith(
            color: Get.theme.colorScheme.onSurface, height: 24.pxToDouble));
    final Text messageText = Text(message,
        style: Get.textTheme.bodyLarge?.copyWith(
            color: Get.theme.colorScheme.onSurface, height: 21.pxToDouble));
    final Text buttonText = Text(positiveLabel ?? 'Ok',
        style: Get.textTheme.bodyLarge?.copyWith(
            color: Get.theme.colorScheme.onSurface, height: 21.pxToDouble));

    final Text buttonCancelText = Text(negativeLabel ?? 'Cancel',
        style: Get.textTheme.bodyLarge?.copyWith(
            color: Get.theme.colorScheme.error, height: 21.pxToDouble));

    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        if (Platform.isAndroid) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            surfaceTintColor: Get.theme.colorScheme.surfaceTint,
            backgroundColor: Get.theme.colorScheme.surfaceContainer,
            title: titleText,
            content: messageText,
            actions: [
              TextButton(
                style: negativeLabelStyle ??
                    TextButton.styleFrom(foregroundColor: Colors.black),
                onPressed: () {
                  Get.back();
                  negativeAction?.call();
                },
                child: buttonCancelText,
              ),
              TextButton(
                style: positiveLabelStyle,
                onPressed: () {
                  Get.back();
                  positiveAction?.call();
                },
                child: buttonText,
              ),
            ],
          );
        }

        return CupertinoAlertDialog(
          title: titleText,
          content: messageText,
          actions: [
            CupertinoDialogAction(
                isDestructiveAction: false,
                onPressed: () {
                  Get.back();
                  negativeAction?.call();
                },
                child: buttonCancelText),
            CupertinoDialogAction(
                isDestructiveAction: false,
                onPressed: () {
                  Get.back();
                  positiveAction?.call();
                },
                child: buttonText),
          ],
        );
      },
    );
  }

  static void showContentDialog({
    required BuildContext context,
    String? title,
    bool scrollable = false,
    TextStyle? titleTextStyle,
    EdgeInsets? iconPadding,
    EdgeInsets? titlePadding,
    EdgeInsets? buttonPadding,
    EdgeInsets? actionsPadding,
    EdgeInsets? contentPadding,
    required Widget content,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          titleTextStyle: titleTextStyle,
          iconPadding: iconPadding,
          titlePadding: titlePadding,
          buttonPadding: buttonPadding,
          actionsPadding: actionsPadding,
          contentPadding: contentPadding,
          scrollable: scrollable,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: title != null ? Text(title) : null,
          content: content,
        );
      },
    );
  }
}
