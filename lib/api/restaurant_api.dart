import 'package:dio/dio.dart';
import 'package:mealmate/models/restaurant_model.dart';
import 'package:mealmate/api/api_config.dart';

class RestaurantApi {
  final Dio _dio = Dio();

  Future<List<Restaurant>> fetchRestaurants({
    required String cuisine,
    required double lat,
    required double lng,
  }) async {
    final url = 'https://api.spoonacular.com/food/restaurants/search';

    try {
      final response = await _dio.get(url, queryParameters: {
        'cuisine': cuisine,
        'lat': lat,
        'lng': lng,
        'apiKey': spoonacularApiKey,
      });

      if (response.statusCode == 200) {
        final List data = response.data['restaurants'];
        return data.map((json) => Restaurant.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching restaurant data');
    }
  }
}
