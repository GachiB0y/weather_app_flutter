import 'package:json_annotation/json_annotation.dart';

part 'hours_weather.g.dart';

@JsonSerializable()
class WeatherHours {
  final int temperature;
  final int humidity;
  final int pressure;
  final int wind;
  final DateTime time;
  final String iconCode;

  WeatherHours(
      {
        required this.temperature,
        required this.humidity,
        required this.pressure,
        required this.iconCode,
        required this.wind,
        required this.time});

  factory WeatherHours.fromJsonApi(Map<String, dynamic> json) {
    return WeatherHours(
        temperature: double.parse(json['main']['temp'].toString()).toInt(),
        humidity: double.parse(json['main']['humidity'].toString()).toInt(),
        pressure: double.parse(json['main']['pressure'].toString()).toInt(),
        wind: double.parse(json['wind']['speed'].toString()).toInt(),
        iconCode: json['weather'][0]['icon'],
        time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)
    );
  }

  factory WeatherHours.fromJson(Map<String, dynamic> json) =>
      _$WeatherHoursFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherHoursToJson(this);
}