import 'package:dio/dio.dart';
import 'package:weather_app/view/main.dart';
import 'package:weather_app/network_manager/model/weather_model.dart';

class NetworkManager {
  final Dio _dio = Dio();

 Future<Welcome> fetchWeather(double latitude, double longitude) async {
  final String url = '';
  try {
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      return Welcome.fromJson(response.data);
    } else {
      throw Exception('Failed to load weather data');
    }
  } catch (e) {
     throw Exception('Error fetching weather data: $e');
  }
 }
}