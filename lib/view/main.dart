import 'package:flutter/material.dart';
import 'package:weather_app/network_manager/model/weather_model.dart';
import 'package:weather_app/network_manager/networking.dart';
import 'package:weather_app/state_management/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/state_management/weather_event.dart';

//APP INITIALIZATION
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

//THE UI
class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  @override
  void initState() {
    super.initState();
     context.read<WeatherBloc>().add(FetchWeather(28.6139, 77.2090));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: BlocBuilder<WeatherBloc, Welcome?>(
            builder: (context, weatherData) {
            if (weatherData == null) {
              return AnimatedLoadingText();
            }
            var tomorrowWeather = weatherData.daily.data[0];
            return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 80,
                        width: 80,
                        child: Image.asset('assets/icons/weather.png')),
                    Text('India',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Temperature tomorrow:${tomorrowWeather.temperature2M}°C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                ),
                SizedBox(
                 height: 20,
                ),
                Text('Wind speed: ${tomorrowWeather.windSpeed10M}m/s',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Humidity: ${tomorrowWeather.relativeHumidity2M}%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            );
            }
        ),
      )
    );
  }
}

//ANIMATED TEXT
class AnimatedLoadingText extends StatefulWidget {
  const AnimatedLoadingText({super.key});

  @override
  State<AnimatedLoadingText> createState() => _AnimatedLoadingTextState();
}

class _AnimatedLoadingTextState extends State<AnimatedLoadingText> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
        vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 2.0).animate(_controller);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _animation,
      child: Text('Loading...',
      style: TextStyle(
        fontSize: 30,
        color: Colors.white70,
        fontWeight: FontWeight.bold,
      ),
      ),
    );
  }
}
