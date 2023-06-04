// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherLoadSuccess _$WeatherLoadSuccessFromJson(Map<String, dynamic> json) =>
    WeatherLoadSuccess(
      weather: Weather.fromJson(json['weather'] as Map<String, dynamic>),
      hourlyWeather: (json['hourlyWeather'] as List<dynamic>)
          .map((e) => WeatherHours.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherLoadSuccessToJson(WeatherLoadSuccess instance) =>
    <String, dynamic>{
      'weather': instance.weather,
      'hourlyWeather': instance.hourlyWeather,
    };
