import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/network_manager/model/weather_model.dart';
import 'package:weather_app/network_manager/networking.dart';
import 'package:weather_app/state_management/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/state_management/weather_event.dart';

/// APP INITIALIZATION
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
       create: (context) => WeatherBloc(NetworkManager()),
        child: const WeatherHomePage(),
      ),
    );
  }
}

/// THE UI
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
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: BlocBuilder<WeatherBloc, Welcome?>(
            builder: (context, weatherData) {
            if (weatherData == null) {
              return const AnimatedLoadingText();
            }
            return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 120,
                        width: 120,
                        child: Image.asset('assets/icons/weather.png')),
                    const Text('India',
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Temperature tomorrow:${weatherData.current.temperature2M}°C',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                ),
                const SizedBox(
                 height: 20,
                ),
                Text('Wind speed: ${weatherData.current.windSpeed10M}m/s',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Humidity: ${weatherData.hourly.relativeHumidity2M.first}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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

/// ANIMATED TEXT
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
      duration: const Duration(seconds: 1),
        vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 2.0).animate(_controller);
  }
 /// DISPOSE THE CONTROLLER
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _animation,
      child: const Text('Loading...',
      style: TextStyle(
        fontSize: 30,
        color: Colors.white70,
        fontWeight: FontWeight.bold,
      ),
      ),
    );
  }
}
