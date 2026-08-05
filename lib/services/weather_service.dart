import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../utils/constants.dart';

class WeatherService {
  Future<WeatherModel> fetchWeather() async {
    try {
      final response = await http.get(Uri.parse(AppEndpoints.openMeteoUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        throw Exception('Failed to load weather data (Code: \${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Network error: \$e');
    }
  }
}
