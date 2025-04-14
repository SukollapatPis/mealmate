// nutrient_api.dart หรือเพิ่มใน recipe_detail.dart ก็ได้
import 'package:dio/dio.dart';
import 'package:mealmate/models/nutrient_model.dart';

class NutrientApi {
  final dio = Dio();

  Future<List<Nutrient>> fetchNutrients(int id, String apiKey) async {
    final response = await dio.get(
      'https://api.spoonacular.com/recipes/$id/nutritionWidget.json',
      queryParameters: {
        'apiKey': apiKey,
      },
    );

    final List<dynamic> nutrientsJson = response.data['nutrients'];
    return nutrientsJson.map((json) => Nutrient.fromJson(json)).toList();
  }
}
