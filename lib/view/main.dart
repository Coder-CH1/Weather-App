import 'package:flutter/material.dart';
import 'package:weather_app/network_manager/model/weather_model.dart';
import 'package:weather_app/network_manager/networking.dart';
import 'package:weather_app/state_management/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/state_management/weather_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
       create: (context) => WeatherBloc(NetworkManager()),
        child: WeatherHomePage(),
      ),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {

  @override
  void initState() {
    super.initState();
   context.read<WeatherBloc>().add(FetchWeather(28.6139, 77.2090));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: BlocBuilder<WeatherBloc, Welcome?>(
            builder: (context, weatherData) {
            if (weatherData == null) {
              return CircularProgressIndicator();
            }
            return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('India',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Current temperature:${weatherData.current.temperature2M}°C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                ),
                SizedBox(
                 height: 20,
                ),
                Text('Wind speed, ${weatherData.current.windSpeed10M}m/s',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                )
              ],
            );
            }
        ),
      )
    );
  }
}
