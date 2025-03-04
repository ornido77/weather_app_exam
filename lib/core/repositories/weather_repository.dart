import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_exam/core/models/weather.dart';

class WeatherRepository {
  final String apiKey = dotenv.env['API_KEY'] ?? '';
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<Weather> fetchWeather(String city, {bool isXml = false}) async {
    final apiKey = dotenv.env['API_KEY'];
    final uri = Uri.parse(
      "$baseUrl?q=$city&appid=$apiKey&units=metric${isXml ? '&mode=xml' : ''}",
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      if (isXml) {
        return Weather.fromXml(response.body, response.body);
      } else {
        return Weather.fromJson(response.body, json.decode(response.body));
      }
    } else if (response.statusCode == 404) {
      throw Exception("City not found...");
    } else {
      throw Exception("Failed to load weather data");
    }
  }
}
