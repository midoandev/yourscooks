import 'package:flutter/material.dart';

class CustomIndicator {
  static Widget get loadingIndicator {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  static Widget get fullScreenIndicator {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
      ),
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
