import 'dart:convert'; // Import for base64 decoding
import 'dart:typed_data';

import 'package:recipe_app/resources/tables_keys_values.dart';

class RecipeModel {
  final String recipeId;
  final String recipeName;
  final String category;
  final String cookingTime;
  final Uint8List recipeImageUrl;
  final List<String> ingredients;
  final List<String> instructions;
  final String createdByName;

  RecipeModel({
    required this.createdByName,
    required this.recipeId,
    required this.recipeName,
    required this.category,
    required this.cookingTime,
    required this.recipeImageUrl,
    required this.ingredients,
    required this.instructions,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      createdByName: json[keyCreatedByName],
      recipeId: json[keyRecipeId],
      recipeName: json[keyRecipeName] ?? '',
      category: json[keyCategory] ?? '',
      cookingTime: json[keyCookingTime] ?? '',
      recipeImageUrl:
          json[keyRecipeImage] != null
              ? base64Decode(json[keyRecipeImage])
              : Uint8List(0),
      ingredients: List<String>.from(json[keyIngredients] ?? []),
      instructions: List<String>.from(json[keyInstructions] ?? []),
    );
  }
  factory RecipeModel.fromMap(String id, Map<String, dynamic> map) {
    return RecipeModel(
      createdByName: map[keyCreatedByName] ?? '',
      recipeId: id, // Use the passed ID
      recipeName: map[keyRecipeName] ?? '',
      category: map[keyCategory] ?? '',
      cookingTime: map[keyCookingTime] ?? '',
      recipeImageUrl:
          map[keyRecipeImage] != null
              ? base64Decode(map[keyRecipeImage])
              : Uint8List(0),
      ingredients: List<String>.from(map[keyIngredients] ?? []),
      instructions: List<String>.from(map[keyInstructions] ?? []),
    );
  }
}
