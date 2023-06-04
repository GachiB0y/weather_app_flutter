import 'package:equatable/equatable.dart';
import 'package:weather_app_flutter/domain/entity/hours_weather.dart';

import '../entity/weather.dart';

import 'package:json_annotation/json_annotation.dart';

part 'weather_state.g.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoadInProgress extends WeatherState {}


@JsonSerializable()
class WeatherLoadSuccess extends WeatherState {
  final Weather weather;
  final List<WeatherHours> hourlyWeather;

  const WeatherLoadSuccess(
      {required this.weather, required this.hourlyWeather})
      : assert(weather != null);

  @override
  List<Object> get props => [weather, hourlyWeather];

  factory WeatherLoadSuccess.fromJson(Map<String, dynamic> json) =>
      _$WeatherLoadSuccessFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherLoadSuccessToJson(this);
}

class WeatherLoadFailure extends WeatherState {}