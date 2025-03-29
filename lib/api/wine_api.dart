import 'package:dio/dio.dart';
import 'package:mealmate/models/wine_pairing_model.dart'; // อย่าลืมนำเข้าโมเดลที่คุณสร้าง

class WineApi {
  final dio = Dio();

  Future<WinePairingModel> getDishPairingsForWine(String wine) async {
    var uri = Uri.https('api.spoonacular.com', '/food/wine/dishes', {
      'apiKey': '6de5a090dd2c4b2795f798d66fc5d774', // ใช้ API Key ของคุณ
      'wine': wine,
    });

    // เรียก API และแปลง JSON เป็น Model
    final response = await dio.get(uri.toString());
    return WinePairingModel.fromJson(response.data);
  }
}