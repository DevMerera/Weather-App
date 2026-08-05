import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../utils/constants.dart';
import '../widgets/hourly_forecast_card.dart';
import '../widgets/weather_metric_item.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  late Future<WeatherModel> _weatherFuture;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _weatherFuture = _weatherService.fetchWeather();
  }

  Future<void> _refreshData() async {
    setState(() {
      _weatherFuture = _weatherService.fetchWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: FutureBuilder<WeatherModel>(
          future: _weatherFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.accentOrange),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.redAccent, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load weather data.\n${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: AppColors.textSecondary, fontSize: 14),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentOrange),
                        onPressed: _refreshData,
                        child: const Text('Retry',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                  child: Text('No data available',
                      style: TextStyle(color: Colors.white)));
            }

            final weather = snapshot.data!;
            final hourlyList = [
              HourlyForecast(
                  time: 'Now',
                  temp: '${weather.temperature.round()}',
                  condition: 'rain',
                  isNight: false),
              HourlyForecast(
                  time: '5pm',
                  temp: '${(weather.temperature - 1).round()}',
                  condition: 'rain',
                  isNight: false),
              HourlyForecast(
                  time: '6pm',
                  temp: '${(weather.temperature - 1).round()}',
                  condition: 'rain',
                  isNight: true),
              HourlyForecast(
                  time: '7pm',
                  temp: '${(weather.temperature - 2).round()}',
                  condition: 'rain',
                  isNight: true),
            ];

            return RefreshIndicator(
              color: AppColors.accentOrange,
              backgroundColor: AppColors.cardDark,
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Top Navigation Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.menu_rounded,
                                color: AppColors.textPrimary, size: 26),
                            onPressed: () {},
                          ),
                          const Text(
                            'Addis Ababa, Ethiopia',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.calendar_today_rounded,
                                color: AppColors.textPrimary, size: 22),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Main Weather Icon / Illustration Graphic container
                      Container(
                        height: 180,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              AppColors.accentOrange.withValues(alpha: 0.35),
                              Colors.transparent,
                            ],
                            radius: 0.8,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 10,
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFD07D),
                                      Color(0xFFFF9F33)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.accentOrange
                                          .withValues(alpha: 0.5),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 15,
                              child: Icon(
                                Icons.cloud_rounded,
                                color: Colors.white,
                                size: 110,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Row(
                                children: List.generate(
                                  3,
                                  (index) => const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Icon(
                                      Icons.water_drop,
                                      color: AppColors.accentBlue,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Temperature and Condition Text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${weather.temperature.round()}',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 72,
                              fontWeight: FontWeight.bold,
                              height: 1.0,
                            ),
                          ),
                          const Text(
                            '° C',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        weather.conditionText,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Weather Metrics Info Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          WeatherMetricItem(
                            icon: Icons.air_rounded,
                            label: '${weather.windSpeed.round()} km/hr',
                          ),
                          WeatherMetricItem(
                            icon: Icons.water_drop_outlined,
                            label: '${weather.humidity}%',
                          ),
                          WeatherMetricItem(
                            icon: Icons.wb_sunny_outlined,
                            label:
                                '${(weather.precipitation * 2 + 6).round()}hr',
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Hourly Forecast Header
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.access_time_rounded,
                                  color: AppColors.textPrimary, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Hourly history',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Hourly Forecast Cards List
                      SizedBox(
                        height: 130,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: hourlyList.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final item = hourlyList[index];
                            return HourlyForecastCard(
                              time: item.time,
                              temperature: item.temp,
                              icon: item.isNight
                                  ? Icons.nightlight_round
                                  : Icons.wb_sunny_outlined,
                              iconColor: AppColors.accentOrange,
                              isSelected: index == 0,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.navBarBackground,
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home_filled,
                  color: _currentIndex == 0
                      ? Colors.white
                      : AppColors.textSecondary),
              onPressed: () => setState(() => _currentIndex = 0),
            ),
            IconButton(
              icon: Icon(Icons.search_rounded,
                  color: _currentIndex == 1
                      ? Colors.white
                      : AppColors.textSecondary),
              onPressed: () => setState(() => _currentIndex = 1),
            ),
            IconButton(
              icon: Icon(Icons.notifications_none_rounded,
                  color: _currentIndex == 2
                      ? Colors.white
                      : AppColors.textSecondary),
              onPressed: () => setState(() => _currentIndex = 2),
            ),
            IconButton(
              icon: Icon(Icons.map_outlined,
                  color: _currentIndex == 3
                      ? Colors.white
                      : AppColors.textSecondary),
              onPressed: () => setState(() => _currentIndex = 3),
            ),
          ],
        ),
      ),
    );
  }
}
