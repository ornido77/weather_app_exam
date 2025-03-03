import 'package:xml/xml.dart' as xml;

class Weather {
  final String city;
  final String countryCode;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String description;
  final String animation;
  final String rawData;
  final bool isXml;

  Weather({
    required this.city,
    required this.countryCode,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.description,
    required this.animation,
    required this.rawData,
    required this.isXml,
  });

  factory Weather.fromJson(String rawData, Map<String, dynamic> json) {
    final condition = json['weather'][0]['main'];
    return Weather(
      city: json['name'],
      countryCode: json["sys"]["country"],
      temperature: json['main']['temp'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      description: json['weather'][0]['description'],
      animation: _mapConditionToLottie(condition),
      rawData: rawData,
      isXml: false,
    );
  }

  factory Weather.fromXml(String rawData, String xmlString) {
    final document = xml.XmlDocument.parse(xmlString);

    final city =
        document.findAllElements('city').first.getAttribute('name') ??
        "Unknown";
    final countryCode =
        document.findAllElements('country').first.innerText.trim();

    final temp = double.parse(
      document.findAllElements('temperature').first.getAttribute('value') ??
          "0.0",
    );

    final tempMin = double.parse(
      document.findAllElements('temperature').first.getAttribute('min') ??
          "0.0",
    );
    final tempMax = double.parse(
      document.findAllElements('temperature').first.getAttribute('max') ??
          "0.0",
    );

    final description =
        document.findAllElements('weather').first.getAttribute('value') ??
        "Unknown";

    final normalizedCondition = description.split(' ')[1].toLowerCase();
    final animation = _mapConditionToLottie(normalizedCondition);

    return Weather(
      city: city,
      countryCode: countryCode,
      temperature: temp,
      tempMin: tempMin,
      tempMax: tempMax,
      description: description,
      animation: animation,
      rawData: rawData,
      isXml: true,
    );
  }

  static String _mapConditionToLottie(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'assets/animations/sunny.json';
      case 'rain':
        return 'assets/animations/rainy.json';
      case 'clouds':
        return 'assets/animations/cloudy.json';
      case 'snow':
        return 'assets/animations/snow.json';
      default:
        return 'assets/animations/default.json';
    }
  }
}
