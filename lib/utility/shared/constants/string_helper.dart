import 'dart:ui';

extension StringHelper on String {
  Color get hexToColor {
    assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(this),
    'hex color must be #rrggbb or #rrggbbaa');

    return Color(
      int.parse(substring(1), radix: 16) +
          (length == 7 ? 0xff000000 : 0x00000000),
    );
  }

  static String randomId() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }


}
