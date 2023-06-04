import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather_app_flutter/domain/api_client/weather_client.dart';
import 'package:weather_app_flutter/domain/blocs/weather_event.dart';
import 'package:weather_app_flutter/domain/blocs/weather_state.dart';
import 'package:weather_app_flutter/domain/entity/hours_weather.dart';
import 'package:weather_app_flutter/domain/entity/weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> with HydratedMixin {
  // final String cityName;

  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherRequested>((event, emit) async {
      emit(WeatherLoadInProgress());
      try {
        final Weather weather =
            await WeatherService.fetchCurrentWeather(query: event.city);
        final List<WeatherHours> hourlyWeather =
            await WeatherService.fetchHourlyWeather(query: event.city);

        emit(
            WeatherLoadSuccess(weather: weather, hourlyWeather: hourlyWeather));
      } catch (_) {
        emit(WeatherLoadFailure());
      }
    });
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    try{
     return WeatherLoadSuccess.fromJson(json);
    }catch(e){
    return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    if(state is WeatherLoadSuccess) {
      return state.toJson();
    }else{ null;}
  }


}
