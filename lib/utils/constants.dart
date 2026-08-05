import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundDark = Color(0xFF151720);
  static const Color cardDark = Color(0xFF1E2130);
  static const Color cardDarkHover = Color(0xFF262A3E);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9EA2B2);
  static const Color accentOrange = Color(0xFFFFB051);
  static const Color accentBlue = Color(0xFF389EEF);
  static const Color navBarBackground = Color(0xFF1A1D2B);
}

class AppEndpoints {
  static const String openMeteoUrl = 
      'https://api.open-meteo.com/v1/forecast?latitude=8.9806&longitude=38.7578&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m,wind_direction_10m';
}
