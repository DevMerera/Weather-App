class WeatherModel {
  final double temperature;
  final double apparentTemperature;
  final int humidity;
  final double windSpeed;
  final double windDirection;
  final double precipitation;
  final int weatherCode;

  WeatherModel({
    required this.temperature,
    required this.apparentTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.precipitation,
    required this.weatherCode,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'] ?? {};
    return WeatherModel(
      temperature: (current['temperature_2m'] ?? 0.0).toDouble(),
      apparentTemperature: (current['apparent_temperature'] ?? 0.0).toDouble(),
      humidity: current['relative_humidity_2m'] ?? 0,
      windSpeed: (current['wind_speed_10m'] ?? 0.0).toDouble(),
      windDirection: (current['wind_direction_10m'] ?? 0.0).toDouble(),
      precipitation: (current['precipitation'] ?? 0.0).toDouble(),
      weatherCode: current['weather_code'] ?? 0,
    );
  }

  String get conditionText {
    switch (weatherCode) {
      case 0:
        return 'Sunny & Clear';
      case 1:
      case 2:
      case 3:
        return 'Partly Cloudy';
      case 45:
      case 48:
        return 'Foggy conditions';
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
        return 'Light Drizzle';
      case 61:
      case 63:
      case 65:
        return 'Expect high rain today';
      case 71:
      case 73:
      case 75:
      case 77:
        return 'Snow expected';
      case 95:
      case 96:
      case 99:
        return 'Thunderstorms';
      default:
        return 'Moderate Weather';
    }
  }
}

class HourlyForecast {
  final String time;
  final String temp;
  final String condition;
  final bool isNight;

  HourlyForecast({
    required this.time,
    required this.temp,
    required this.condition,
    this.isNight = false,
  });
}
