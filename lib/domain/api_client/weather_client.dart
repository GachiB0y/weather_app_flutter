import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_flutter/domain/entity/hours_weather.dart';
import 'package:weather_app_flutter/domain/entity/weather.dart';

class WeatherService {
  static String _apiKey = "359e265b7f821a525ff0722c6b01571f"; //439d4b804bc8187953eb36d2a8c26a02

  static Future<Weather> fetchCurrentWeather({query}) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$query&appid=$_apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  static Future<List<WeatherHours>> fetchHourlyWeather({String query =''}) async {
    var url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$query&appid=$_apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<WeatherHours> data = (jsonData['list'] as List<dynamic>)
          .map((item) {
        return WeatherHours.fromJson(item);
      }).toList();
      return data;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}