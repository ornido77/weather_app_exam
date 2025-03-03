import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_exam/core/repositories/weather_repository.dart';
import 'package:weather_app_exam/features/weather/bloc/weather_bloc.dart';
import 'package:weather_app_exam/features/weather/weather_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create:
            (context) => WeatherBloc(weatherRepository: WeatherRepository()),
        child: WeatherPage(),
      ),
    );
  }
}
