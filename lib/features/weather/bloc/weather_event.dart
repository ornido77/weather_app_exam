part of 'weather_bloc.dart';

abstract class WeatherEvent {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final String city;
  final bool isXml;
  const FetchWeather(this.city, {this.isXml = false});
}
