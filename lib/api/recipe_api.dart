import 'package:dio/dio.dart';
import 'package:mealmate/models/search_result_model.dart';
import 'api_config.dart';
class RecipeApi {
  final dio = Dio();

  Future<SearchResultModel> searchRecipes(String query, String cuisine, String type) async {
    var params = {
      'apiKey': spoonacularApiKey,
      'query': query,
      'number': '100',  // กำหนดจำนวนผลลัพธ์
    };

    if (cuisine != "All") {
      params['cuisine'] = cuisine;
    }

    if (type != "All") {
      params['type'] = type;
    }

    var uri = Uri.https('api.spoonacular.com', '/recipes/complexSearch', params);

    // อ่าน API เป็น JSON แล้วแปลงเป็น Model ส่งค่าไปตอบกลับ
    final response = await dio.get(uri.toString());
    return SearchResultModel.fromJson(response.data);
  }
}