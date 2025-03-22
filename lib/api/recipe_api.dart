import 'package:dio/dio.dart';
import 'package:mealmate/models/search_result_model.dart';

class RecipeApi {
  final dio = Dio();

  Future<SearchResultModel> searchRecipes() async {
    // อ่าน API เป็น JSON แล้วแปลงเป็น Model ส่งค่าไปตอบกลับ
    final response = await dio.get('https://api.spoonacular.com/recipes/complexSearch?apiKey=6de5a090dd2c4b2795f798d66fc5d774&number=100&cuisine=Thai&type=main course');
    return SearchResultModel.fromJson(response.data);
  }

  
}