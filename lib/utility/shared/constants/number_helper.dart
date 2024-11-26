
import 'package:flutter/cupertino.dart';
//
// extension DoubleHelper on double {
//   String get roundPercentageAsPrecision =>
//       '${toStringAsPrecision(2)}%';
//
//   double get pxToDouble {
//     return 0.08333333 * toDouble();
//   }
//   SizedBox get zh => SizedBox(height: this);
//   SizedBox get zw => SizedBox(width: this);
// }
// extension IntegerHelper on int {
//   double get pxToDouble {
//     return 0.08333333 * this;
//   }
//   SizedBox get zw => SizedBox(width: toDouble());
//   SizedBox get zh => SizedBox(height: toDouble());
//
// }
import 'package:flutter/material.dart';

extension NumberHelper<T extends num> on T {
  String get roundPercentageAsPrecision {
    if (this is double) {
      return '${(this as double).toStringAsPrecision(2)}%';
    }
    return '$this%'; // Default for integers
  }

  double get pxToDouble {
    return 0.08333333 * toDouble();
  }

  SizedBox get zh => SizedBox(height: toDouble());
  SizedBox get zw => SizedBox(width: toDouble());
  BorderRadius get circularBorder => BorderRadius.all(Radius.circular(toDouble()));
}