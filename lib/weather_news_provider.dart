import 'package:flutter/material.dart';
import 'api_service.dart';

class WeatherNewsProvider with ChangeNotifier {
  final ApiService apiService = ApiService();
  Map<String, dynamic>? _weatherData;
  List<dynamic> _newsArticles = [];
  bool _isLoading = false;
 int? get temperature => _weatherData?['current']['temperature'];
  Map<String, dynamic>? get weatherData => _weatherData;
  List<dynamic> get newsArticles => _newsArticles;
  bool get isLoading => _isLoading;

  Future<void> fetchWeatherAndNews(String city) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weatherData = await apiService.fetchWeather(city);
      String weatherDescription = _weatherData!['current']['temperature'];
      _newsArticles = await apiService.fetchNews(weatherDescription);
    } catch (e) {
      
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
