import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String weatherApiKey = 'af4142413d541e435fcbe26508b407a9';
  final String newsApiKey = 'af4142413d541e435fcbe26508b407a9';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final weatherUrl =
        'https://api.weatherstack.com/current?access_key=$weatherApiKey&query=$city';
    final response = await http.get(Uri.parse(weatherUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<dynamic>> fetchNews(String query) async {
    final newsUrl =
        'https://newsapi.org/v2/everything?q=$query&apiKey=$newsApiKey';
    final response = await http.get(Uri.parse(newsUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body)['articles'];
    } else {
      throw Exception('Failed to load news articles');
    }
  }
}
