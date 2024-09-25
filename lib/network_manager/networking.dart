import 'package:dio/dio.dart';
import 'package:weather_app/network_manager/model/weather_model.dart';

//NETWORK REQUEST USING DIO
class NetworkManager {
  final Dio _dio = Dio();

 Future<Welcome> fetchWeather(double latitude, double longitude) async {
   final String url = 'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m';

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