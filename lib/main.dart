import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_news_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherNewsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather-Based News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherNewsScreen(),
    );
  }
}

class WeatherNewsScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherNewsProvider = Provider.of<WeatherNewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather-Based News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter city'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String city = _controller.text.trim();
                if (city.isNotEmpty) {
                  weatherNewsProvider.fetchWeatherAndNews(city);
                }
              },
              child: Text('Get Weather & News'),
            ),
            SizedBox(height: 20),
            weatherNewsProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: weatherNewsProvider.newsArticles.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(weatherNewsProvider.newsArticles[index]['title']),
                          subtitle: Text(weatherNewsProvider.newsArticles[index]['description'] ?? ''),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
