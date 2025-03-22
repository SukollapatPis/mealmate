import 'package:mealmate/models/recipe_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'search_result_model.g.dart';

@JsonSerializable()
class SearchResultModel {
  final List<RecipeModel> results;

  SearchResultModel({
    required this.results,
  });

  // ===========================================================================
  // Run this command to generate the code *** ทุกครั้งที่เรียกใช้ API ใหม่
  // flutter pub run build_runner build --delete-conflicting-outputs
  /// factory.
  factory SearchResultModel.fromJson(Map<String, dynamic> json) => _$SearchResultModelFromJson(json);

  /// Connect the generated [_$SearchResultModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SearchResultModelToJson(this);

  // ===========================================================================

}