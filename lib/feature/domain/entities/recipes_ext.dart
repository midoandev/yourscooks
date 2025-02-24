import 'package:yourscooks/feature/domain/entities/recipes.dart';
import 'package:yourscooks/utility/shared/utils/string_helper.dart';

extension RecipesExt on Recipes {
  String get nameClean => (name ?? '').replaceAll("&quot;", '"');

  static String convertTimeFromApi(String time) {
    final regex = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?');
    final match = regex.firstMatch(time ?? '');

    if (match == null) {
      // throw FormatException("Invalid time format: $time");
      return '';
    }

    // Ambil nilai jam dan menit, default ke 0 jika null
    final hours = int.tryParse(match.group(1) ?? '0') ?? 0;
    final minutes = int.tryParse(match.group(2) ?? '0') ?? 0;

    // Konversi semuanya ke menit
    final mins = (hours * 60) + minutes;
    return '$mins';
  }

  List<String> textToList({String? textList}) {
    if (textList == null) return [];
    if (textList == 'character(0)') return [];
    if (!textList.contains('c(')) {
      return [textList];
    }
    String trimmedResponse = textList.substring(2, textList.length - 1);

    List<String> result = trimmedResponse.split(', ');

    List<String> cleanResult =
        result.map((url) => url.removeQuoteChar).toList();
    return cleanResult;
  }


  String get imagesFirst {
    if (images == null) return '';
    if (images!.isEmpty) return '';
    return images!.first;
  }

  List<String> get listIngredientQuantities {
    return textToList(textList: recipeIngredientQuantities);
  }

  List<String> get listIngredientParts {
    return textToList(textList: recipeIngredientParts);
  }

  List<String> get listInstruction {
    return textToList(textList: recipeInstructions);
  }

  String get totalTimeCook => convertTimeFromApi(totalTime ?? '');

  String get prepTimeCook => convertTimeFromApi(prepTime ?? '');

  String get timeCooking => convertTimeFromApi(cookTime ?? '');

  String get formatRating {
    try {
      if (aggregatedRating == null) return '0';
      double parsedRating = double.parse(aggregatedRating.toString());
      return parsedRating.toString();
    } catch (e) {
      throw FormatException("Rating is not a valid number: $aggregatedRating");
    }
  }
}
