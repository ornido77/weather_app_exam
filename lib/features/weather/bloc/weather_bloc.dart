import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_exam/core/models/weather.dart';
import 'package:weather_app_exam/core/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  void _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.fetchWeather(
        event.city,
        isXml: event.isXml,
      );
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
