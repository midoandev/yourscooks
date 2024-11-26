import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


extension NumHelper<T extends num> on T {
  String get roundPercentageAsPrecision =>
      '${toStringAsPrecision(2)}%';


  double get pxToDouble {
    return 0.08333333 * toDouble();
  }

  String get toFormattedDate {
    int toInt = this.toInt() * 1000;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(toInt);
    DateFormat formatter = DateFormat('dd MMM yyyy HH:mm', 'ID_id');
    String formattedDate = formatter.format(dateTime);
    return '$formattedDate WIB';
  }


  SizedBox get zw => SizedBox(width: toDouble());
  SizedBox get zh => SizedBox(height: toDouble());
  get p => EdgeInsets.all(toDouble());
  get ph => EdgeInsets.symmetric(horizontal: toDouble());
  get pv => EdgeInsets.symmetric(vertical: toDouble());
  Radius get circularRadius => Radius.circular(toDouble());
}
