import 'package:yourscooks/feature/domain/entities/recipes.dart';

extension RecipesExt on Recipes {
  String get imagesFirst {
    if (images == null || images == 'character(0)') return '';
    if (!images!.contains('c(')) {
      return images!;
    }
    String trimmedResponse = images!.substring(2, images!.length - 1);

    List<String> urls = trimmedResponse.split(', ');

    return urls.first.trim();
  }

  String get totalTimeCook {
    final regex = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?');
    final match = regex.firstMatch(totalTime ?? '');

    if (match == null) {
      throw FormatException("Invalid time format: $totalTime");
    }

    // Ambil nilai jam dan menit, default ke 0 jika null
    final hours = int.tryParse(match.group(1) ?? '0') ?? 0;
    final minutes = int.tryParse(match.group(2) ?? '0') ?? 0;

    // Konversi semuanya ke menit
    final mins = (hours * 60) + minutes;
    return '${mins} mins';
  }

  String get formatRating {
    try {
      if (aggregatedRating == null) return '0';
      double parsedRating = double.parse(aggregatedRating!);
      return parsedRating.toString();
    } catch (e) {
      throw FormatException("Rating is not a valid number: $aggregatedRating");
    }
  }
}
