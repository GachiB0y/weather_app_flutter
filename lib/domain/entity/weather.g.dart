// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      cityName: json['cityName'] as String,
      temperature: json['temperature'] as int,
      feelsLike: json['feelsLike'] as int,
      humidity: json['humidity'] as int,
      pressure: json['pressure'] as int,
      wind: json['wind'] as int,
      iconCode: json['iconCode'] as String,
      description: json['description'] as String,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'cityName': instance.cityName,
      'temperature': instance.temperature,
      'feelsLike': instance.feelsLike,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'wind': instance.wind,
      'iconCode': instance.iconCode,
      'description': instance.description,
      'time': instance.time.toIso8601String(),
    };
