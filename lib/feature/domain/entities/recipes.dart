import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipes.freezed.dart';

part 'recipes.g.dart';

@freezed
class Recipes with _$Recipes {
  const factory Recipes({
    @JsonKey(name: "RecipeId") int? recipeId,
    @JsonKey(name: "Name") String? name,
    @JsonKey(name: "AuthorId") int? authorId,
    @JsonKey(name: "AuthorName") String? authorName,
    @JsonKey(name: "CookTime") String? cookTime,
    @JsonKey(name: "PrepTime") String? prepTime,
    @JsonKey(name: "TotalTime") String? totalTime,
    @JsonKey(name: "DatePublished") DateTime? datePublished,
    @JsonKey(name: "Description") String? description,
    @JsonKey(name: "Images") String? images,
    @JsonKey(name: "RecipeCategory") String? recipeCategory,
    @JsonKey(name: "Keywords") String? keywords,
    @JsonKey(name: "RecipeIngredientQuantities")
    String? recipeIngredientQuantities,
    @JsonKey(name: "RecipeIngredientParts") String? recipeIngredientParts,
    @JsonKey(name: "AggregatedRating") int? aggregatedRating,
    @JsonKey(name: "ReviewCount") int? reviewCount,
    @JsonKey(name: "Calories") double? calories,
    @JsonKey(name: "FatContent") double? fatContent,
    @JsonKey(name: "SaturatedFatContent") double? saturatedFatContent,
    @JsonKey(name: "CholesterolContent") double? cholesterolContent,
    @JsonKey(name: "SodiumContent") double? sodiumContent,
    @JsonKey(name: "CarbohydrateContent") double? carbohydrateContent,
    @JsonKey(name: "FiberContent") double? fiberContent,
    @JsonKey(name: "SugarContent") double? sugarContent,
    @JsonKey(name: "ProteinContent") double? proteinContent,
    @JsonKey(name: "RecipeServings") int? recipeServings,
    @JsonKey(name: "RecipeYield") String? recipeYield,
    @JsonKey(name: "RecipeInstructions") String? recipeInstructions,
  }) = _Recipes;

  factory Recipes.fromJson(Map<String, dynamic> json) =>
      _$RecipesFromJson(json);
}
