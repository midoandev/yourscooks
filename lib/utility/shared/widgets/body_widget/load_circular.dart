import 'package:flutter/material.dart';

class LoadCircular extends StatelessWidget {
  const LoadCircular({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
            width: 24, height: 24, child: CircularProgressIndicator()));
  }
}
