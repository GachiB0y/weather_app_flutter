
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_flutter/domain/api_client/weather_client.dart';
import 'package:weather_app_flutter/domain/blocs/weather_event.dart';
import 'package:weather_app_flutter/domain/blocs/weather_state.dart';
import 'package:weather_app_flutter/domain/entity/hours_weather.dart';
import 'package:weather_app_flutter/domain/entity/weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final String cityName;

  WeatherBloc(this.cityName) : super(WeatherInitial()) {
    on<WeatherRequested>((event, emit) async {
      emit(WeatherLoadInProgress());
      try {
              final Weather weather =
              await WeatherService.fetchCurrentWeather(query: event.city);
              final List<WeatherHours> hourlyWeather =
              await WeatherService.fetchHourlyWeather(query: event.city);
              print("goodConntect");
             emit(WeatherLoadSuccess(weather: weather, hourlyWeather: hourlyWeather));
            } catch (_) {
              emit( WeatherLoadFailure());
            }
    });

  }

  // @override
  // Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
  //   if (event is WeatherRequested) {
  //     yield WeatherLoadInProgress();
  //     try {
  //       final Weather weather =
  //       await WeatherService.fetchCurrentWeather(query: event.city);
  //       final List<Weather> hourlyWeather =
  //       await WeatherService.fetchHourlyWeather(query: event.city);
  //       yield WeatherLoadSuccess(
  //           weather: weather, hourlyWeather: hourlyWeather);
  //     } catch (_) {
  //       yield WeatherLoadFailure();
  //     }
  //   }
  // }
}