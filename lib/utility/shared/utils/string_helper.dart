import 'package:get/get_utils/src/extensions/string_extensions.dart';

extension StringExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';

  String get allInCaps => toUpperCase();

  String get capitalizeFirstOfEach {
    return split(' ').map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  String get capitalizeFirstofEach =>
      split(' ').map((str) => str.capitalize).join(' ');

  String toSnackCase() {
    return replaceAll(RegExp(' +'), '_').toLowerCase();
  }

  String toTitleCase() {
    return replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => str.capitalize)
        .join(' ');
  }

  String get inStringify => replaceAll('"', '\\"')
      .replaceAll('\n', '\\n    ')
      .replaceAll(',', ',\\n    ')
      .replaceAll(':', ': ')
      .replaceAll('{', '{\\n    ')
      .replaceAll('}', '\\n    }');

  String get trueEnumFormat => replaceAll('__', ':').replaceAll('_', '-');

  String get normalText =>
      replaceAll('_', ' ').split(' ').map((str) => str.capitalize).join(' ');

  bool get isKosong => isEmpty;


  String get lastString => this[length - 1];

  String get snakeCase {
    String result = replaceAll(' ', '_').toLowerCase();
    return result;
  }

  String get toCamelCase => snakeCase
      .split('_')
      .map((word) => word.substring(0, 1).toUpperCase() + word.substring(1))
      .join(' ');

  String get spaceToUnderscore => replaceAll(' ', '_');

// String toCamelCase(String snakeCase, {bool upperCase = true}) {
//   String result = snakeCase.split('_').map((word) => word.substring(0,1).toUpperCase() + word.substring(1)).join('');
//   if (!upperCase) {
//     result = result.substring(0,1).toLowerCase() + result.substring(1);
//   }
//   return result;
// }

  String stripHtmlIfNeeded() {
    return replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
  }

  String replaceSubject(String name) {
    final expression = RegExp(
        r'({subject}|{{ subject }}|{{subject}}|{{subject]}?|({\[subject}})|{{subject }}|{{subject ]}|{{ subject}}|{{ Subject }}|{{Subject}}|{{Subject]}|({\[Subject}})|{{Subject }}|{{Subject ]}|{{ Subject}}|{ Subject }}|{ subject }})');
    return replaceAll(expression, name);
  }
}