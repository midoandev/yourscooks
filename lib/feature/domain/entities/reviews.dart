import 'package:freezed_annotation/freezed_annotation.dart';

part 'reviews.freezed.dart';

part 'reviews.g.dart';

@freezed
class Reviews with _$Reviews {
  const factory Reviews({
    @JsonKey(name: "ReviewId") String? reviewId,
    @JsonKey(name: "RecipeId") String? recipeId,
    @JsonKey(name: "AuthorId") String? authorId,
    @JsonKey(name: "AuthorName") String? authorName,
    @JsonKey(name: "Rating") String? rating,
    @JsonKey(name: "Review") String? review,
    @JsonKey(name: "DateSubmitted") DateTime? dateSubmitted,
    @JsonKey(name: "DateModified") DateTime? dateModified,
  }) = _Reviews;

  factory Reviews.fromJson(Map<String, dynamic> json) =>
      _$ReviewsFromJson(json);
}
