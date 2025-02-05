import 'dart:convert';

class ReviewsResponse {
  String? reviewId;
  String? recipeId;
  String? authorId;
  String? authorName;
  String? rating;
  String? review;
  DateTime? dateSubmitted;
  DateTime? dateModified;

  ReviewsResponse({
    this.reviewId,
    this.recipeId,
    this.authorId,
    this.authorName,
    this.rating,
    this.review,
    this.dateSubmitted,
    this.dateModified,
  });

  factory ReviewsResponse.fromRawJson(String str) => ReviewsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) => ReviewsResponse(
    reviewId: json["ReviewId"],
    recipeId: json["RecipeId"],
    authorId: json["AuthorId"],
    authorName: json["AuthorName"],
    rating: json["Rating"],
    review: json["Review"],
    dateSubmitted: json["DateSubmitted"] == null ? null : DateTime.parse(json["DateSubmitted"]),
    dateModified: json["DateModified"] == null ? null : DateTime.parse(json["DateModified"]),
  );

  Map<String, dynamic> toJson() => {
    "ReviewId": reviewId,
    "RecipeId": recipeId,
    "AuthorId": authorId,
    "AuthorName": authorName,
    "Rating": rating,
    "Review": review,
    "DateSubmitted": dateSubmitted?.toIso8601String(),
    "DateModified": dateModified?.toIso8601String(),
  };
}
