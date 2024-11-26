import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class BottomSheetDefault extends StatelessWidget {
  final Widget body;

  const BottomSheetDefault({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorConstants.kGrey,
                ),
              ),
            ),
            const SizedBox(height: 24),
            body
          ],
        ));
  }
}
