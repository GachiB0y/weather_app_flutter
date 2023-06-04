import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  final String cityName;
  final int temperature;
  final int feelsLike;
  final int humidity;
  final int pressure;
  final int wind;
  final String iconCode;
  final String description;
  final DateTime time;

  Weather(
      { required this.cityName,
        required this.temperature,
        required this.feelsLike,
        required this.humidity,
        required this.pressure,
        required this.wind,
        required this.iconCode,
        required this.description,
        required this.time});


  factory Weather.fromJsonApi(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: double.parse(json['main']['temp'].toString()).toInt(),
        feelsLike: double.parse(json['main']['feels_like'].toString()).toInt(),
        humidity: double.parse(json['main']['humidity'].toString()).toInt(),
        pressure: double.parse(json['main']['pressure'].toString()).toInt(),
        wind: double.parse(json['wind']['speed'].toString()).toInt(),
        iconCode: json['weather'][0]['icon'],
        description: json['weather'][0]['main'],
        time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)
    );
  }

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}