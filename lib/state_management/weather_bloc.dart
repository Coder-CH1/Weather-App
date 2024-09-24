import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_event.dart';
import 'package:weather_app/network_manager/networking.dart';
import 'package:weather_app/network_manager/model/weather_model.dart';


class WeatherBloc extends Bloc<WeatherEvent, Welcome?> {
  final NetworkManager networkManager;

  WeatherBloc(this.networkManager) : super(null);

  @override

  Stream<Welcome?> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      try {
        final weather = await networkManager.fetchWeather(event.latitude, event.longitude);
        yield weather;
      } catch (_) {
        yield null;
      }
    }
  }
}