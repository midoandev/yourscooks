import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourscooks/utility/shared/utils/number_helper.dart';

class CustomRadioButton extends StatelessWidget {
  final String value;
  final bool isSelected;

  final String label;
  final Function() onPress;

  const CustomRadioButton(
      {super.key, required this.value,
      required this.isSelected,
      required this.label,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: 8.pv,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Get.theme.primaryColor.withOpacity(0.1)
              : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Spacer(),
            Container(
              height: 24.0,
              width: 24.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Get.theme.primaryColor : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: isSelected
                    ? Container(
                  height: 16.0,
                  width: 16.0,
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
