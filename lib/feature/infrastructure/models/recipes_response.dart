import 'dart:convert';

class RecipesResponse {
  int? recipeId;
  String? name;
  int? authorId;
  String? authorName;
  String? cookTime;
  String? prepTime;
  String? totalTime;
  DateTime? datePublished;
  String? description;
  String? images;
  String? recipeCategory;
  String? keywords;
  String? recipeIngredientQuantities;
  String? recipeIngredientParts;
  String? aggregatedRating;
  String? reviewCount;
  double? calories;
  double? fatContent;
  double? saturatedFatContent;
  double? cholesterolContent;
  double? sodiumContent;
  double? carbohydrateContent;
  double? fiberContent;
  double? sugarContent;
  double? proteinContent;
  String? recipeServings;
  String? recipeYield;
  String? recipeInstructions;

  RecipesResponse({
    this.recipeId,
    this.name,
    this.authorId,
    this.authorName,
    this.cookTime,
    this.prepTime,
    this.totalTime,
    this.datePublished,
    this.description,
    this.images,
    this.recipeCategory,
    this.keywords,
    this.recipeIngredientQuantities,
    this.recipeIngredientParts,
    this.aggregatedRating,
    this.reviewCount,
    this.calories,
    this.fatContent,
    this.saturatedFatContent,
    this.cholesterolContent,
    this.sodiumContent,
    this.carbohydrateContent,
    this.fiberContent,
    this.sugarContent,
    this.proteinContent,
    this.recipeServings,
    this.recipeYield,
    this.recipeInstructions,
  });

  factory RecipesResponse.fromRawJson(String str) => RecipesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipesResponse.fromJson(Map<String, dynamic> json) => RecipesResponse(
    recipeId: json["RecipeId"],
    name: json["Name"],
    authorId: json["AuthorId"],
    authorName: json["AuthorName"],
    cookTime: json["CookTime"],
    prepTime: json["PrepTime"],
    totalTime: json["TotalTime"],
    datePublished: json["DatePublished"] == null ? null : DateTime.parse(json["DatePublished"]),
    description: json["Description"],
    images: json["Images"],
    recipeCategory: json["RecipeCategory"],
    keywords: json["Keywords"],
    recipeIngredientQuantities: json["RecipeIngredientQuantities"],
    recipeIngredientParts: json["RecipeIngredientParts"],
    aggregatedRating: json["AggregatedRating"],
    reviewCount: json["ReviewCount"],
    calories: json["Calories"]?.toDouble(),
    fatContent: json["FatContent"]?.toDouble(),
    saturatedFatContent: json["SaturatedFatContent"]?.toDouble(),
    cholesterolContent: json["CholesterolContent"]?.toDouble(),
    sodiumContent: json["SodiumContent"]?.toDouble(),
    carbohydrateContent: json["CarbohydrateContent"]?.toDouble(),
    fiberContent: json["FiberContent"]?.toDouble(),
    sugarContent: json["SugarContent"]?.toDouble(),
    proteinContent: json["ProteinContent"]?.toDouble(),
    recipeServings: json["RecipeServings"],
    recipeYield: json["RecipeYield"],
    recipeInstructions: json["RecipeInstructions"],
  );

  Map<String, dynamic> toJson() => {
    "RecipeId": recipeId,
    "Name": name,
    "AuthorId": authorId,
    "AuthorName": authorName,
    "CookTime": cookTime,
    "PrepTime": prepTime,
    "TotalTime": totalTime,
    "DatePublished": datePublished?.toIso8601String(),
    "Description": description,
    "Images": images,
    "RecipeCategory": recipeCategory,
    "Keywords": keywords,
    "RecipeIngredientQuantities": recipeIngredientQuantities,
    "RecipeIngredientParts": recipeIngredientParts,
    "AggregatedRating": aggregatedRating,
    "ReviewCount": reviewCount,
    "Calories": calories,
    "FatContent": fatContent,
    "SaturatedFatContent": saturatedFatContent,
    "CholesterolContent": cholesterolContent,
    "SodiumContent": sodiumContent,
    "CarbohydrateContent": carbohydrateContent,
    "FiberContent": fiberContent,
    "SugarContent": sugarContent,
    "ProteinContent": proteinContent,
    "RecipeServings": recipeServings,
    "RecipeYield": recipeYield,
    "RecipeInstructions": recipeInstructions,
  };
}
