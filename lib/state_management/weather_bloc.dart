import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:hive/hive.dart';
import 'weather_event.dart';
import 'package:weather_app/network_manager/networking.dart';
import 'package:weather_app/network_manager/model/weather_model.dart';

//BLOC STATE MANAGEMENT
class WeatherBloc extends Bloc<WeatherEvent, Welcome?> {
  final NetworkManager networkManager;
  //final Box<Welcome> weatherBox;

  WeatherBloc(this.networkManager) : super(null) {
    on<FetchWeather>((event, emit) async {
      try {
        final weather = await networkManager.fetchWeather(
            event.latitude, event.longitude);
        //await weatherBox.put('weather', weather);
        emit(weather);
      } catch (_) {
        //final cachedWeatherData = weatherBox.get('weather');
        emit(null);
      }
    });
  }
}


