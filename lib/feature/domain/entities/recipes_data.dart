import 'package:yourscooks/feature/domain/entities/recipes.dart';

class RecipesData {
  List<Recipes> recipes;
  dynamic lastDocument;

  RecipesData({required this.recipes, this.lastDocument});
}
