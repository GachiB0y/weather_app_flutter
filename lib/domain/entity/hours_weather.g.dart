// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hours_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherHours _$WeatherHoursFromJson(Map<String, dynamic> json) => WeatherHours(
      temperature: json['temperature'] as int,
      humidity: json['humidity'] as int,
      pressure: json['pressure'] as int,
      iconCode: json['iconCode'] as String,
      wind: json['wind'] as int,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$WeatherHoursToJson(WeatherHours instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'wind': instance.wind,
      'time': instance.time.toIso8601String(),
      'iconCode': instance.iconCode,
    };
