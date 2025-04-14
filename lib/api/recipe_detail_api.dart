import 'package:dio/dio.dart';
import 'package:mealmate/models/recipe_model.dart';

class RecipeDetailApi {
  final dio = Dio();

  Future<RecipeModel> fetchRecipeInformation(int id, String apiKey) async {
    final response = await dio.get(
      'https://api.spoonacular.com/recipes/$id/information',
      queryParameters: {
        'includeNutrition': false,
        'apiKey': apiKey,
      },
    );

    return RecipeModel.fromJson(response.data);
  }
}
