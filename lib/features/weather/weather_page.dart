import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_exam/features/weather/bloc/weather_bloc.dart';
import 'package:weather_app_exam/utils/utils.dart';
import 'package:xml/xml.dart' as xml;

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.deepPurple, Colors.black],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Expanded(child: _buildWeatherInfo()),
              const SizedBox(height: 20),
              _buildTextField(),
              const SizedBox(height: 20),
              _buildButtonRow(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _buildWeatherInfo() {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/default.json',
                      width: 250,
                      height: 250,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Planning a trip? Curious about the weather? 🌤️\nType a city and find out now!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ],
                );
              } else if (state is WeatherLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              } else if (state is WeatherLoaded) {
                return InkWell(
                  onTap: () {
                    String title =
                        state.weather.isXml ? "XML Response" : "JSON Response";
                    String content =
                        state.weather.isXml
                            ? xml.XmlDocument.parse(
                              state.weather.rawData,
                            ).toXmlString(pretty: true)
                            : jsonEncode(json.decode(state.weather.rawData));

                    showDataDialog(context, title, content);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                getCountryFlag(state.weather.countryCode),
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                getCountryName(state.weather.countryCode),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            getGreeting(),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      if (state.weather.animation.isNotEmpty)
                        Lottie.asset(
                          state.weather.animation,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                      Text(
                        state.weather.city,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        getFormattedDateTime(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${state.weather.temperature}°C",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 5),
                      Text(
                        state.weather.description,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 5),

                      const SizedBox(height: 5),
                      _buildDetailRow(
                        _buildIconRow(
                          '🔥',
                          "${state.weather.tempMax}°C",
                          'Temp Max',
                        ),
                        _buildIconRow(
                          '🧊',
                          "${state.weather.tempMin}°C",
                          'Temp Min',
                        ),
                      ),
                      _buildDetailRow(
                        _buildIconRow(
                          '💧',
                          "${state.weather.humidity}%",
                          'Humidity',
                        ),
                        _buildIconRow(
                          '💨',
                          "${(state.weather.windSpeed * 3.6).toStringAsFixed(2)}°km/h",
                          'Wind Speed',
                        ),
                      ),
                      Text(
                        getWeatherPhrase(state.weather.description),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is WeatherError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      state.message.contains('found')
                          ? 'assets/animations/not_found.json'
                          : 'assets/animations/error.json',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.redAccent),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Row _buildDetailRow(Widget child1, Widget child2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 1, child: child1),
        Expanded(flex: 1, child: child2),
      ],
    );
  }

  Row _buildIconRow(String logo, String value, String label) {
    return Row(
      children: [
        Text(logo, style: const TextStyle(fontSize: 34, color: Colors.white70)),
        Column(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  TextField _buildTextField() {
    return TextField(
      controller: cityController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "Enter city",
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.location_city, color: Colors.white70),
        filled: true,
        fillColor: Colors.white24,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        suffixIcon:
            cityController.text.isNotEmpty
                ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white70),
                  onPressed: () => cityController.clear(),
                )
                : null,
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(
          context: context,
          isXml: false,
          color: Colors.deepPurpleAccent,
        ),
        _buildButton(context: context, isXml: true, color: Colors.blueAccent),
      ],
    );
  }

  ElevatedButton _buildButton({
    required BuildContext context,
    required bool isXml,
    required Color color,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        FocusScope.of(context).unfocus();
        BlocProvider.of<WeatherBloc>(
          context,
        ).add(FetchWeather(cityController.text, isXml: isXml));
      },
      child: Text(
        "Fetch ${isXml ? 'XML' : 'JSON'}",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
