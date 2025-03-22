import 'package:json_annotation/json_annotation.dart';
part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeModel {
  final int id;
  final String title;
  final String image;
  final String imageType;

  RecipeModel({
    required this.id,
    required this.title,
    required this.image,
    required this.imageType,
  });

  /// factory.
  factory RecipeModel.fromJson(Map<String, dynamic> json) => _$RecipeModelFromJson(json);

  /// Connect the generated [_$RecipeModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);
}