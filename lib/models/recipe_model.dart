import 'package:json_annotation/json_annotation.dart';
part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeModel {
  final int id;
  final String title;
  final String image;
  final String imageType;
  final List<String> dishTypes;
  final bool vegetarian;
  final int readyInMinutes;
  final int? preparationMinutes;
  final int? cookingMinutes;
  final List<Ingredient> extendedIngredients;

  RecipeModel({
    required this.id,
    required this.title,
    required this.image,
    required this.imageType,
    required this.dishTypes,
    required this.vegetarian,
    required this.readyInMinutes,
    this.preparationMinutes,
    this.cookingMinutes,
    required this.extendedIngredients,
  });

  /// factory.
  factory RecipeModel.fromJson(Map<String, dynamic> json) => _$RecipeModelFromJson(json);

  /// Connect the generated [_$RecipeModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);
}

@JsonSerializable()
class Ingredient {
  final String name;
  final double amount;
  final String? unit;
  final String? aisle;

  
  Ingredient({
    required this.name,
    required this.amount,
    this.unit,
    this.aisle,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}