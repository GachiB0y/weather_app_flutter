import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather_app_flutter/domain/blocs/weather_bloc.dart';
import 'package:weather_app_flutter/domain/blocs/weather_event.dart';
import 'package:weather_app_flutter/domain/blocs/weather_state.dart';
import 'package:weather_app_flutter/ui/component/weather_element_widget.dart';
import 'package:weather_app_flutter/ui/navigation/main_navigation_route_name.dart';

class WeatherWidget extends StatefulWidget {
  var city;
  WeatherWidget({Key? key, required this.city}) : super(key: key);

  static Widget create(String city) {
    return BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc(),
      child: WeatherWidget(
        city: city,
      ),
    );
  }

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  final TextEditingController searchController = TextEditingController();

  final _storage = HydratedBloc.storage;
  @override
  void initState() {
    if(_storage.runtimeType.toString().isEmpty){
      BlocProvider.of<WeatherBloc>(context)
          .add(WeatherRequested(city: widget.city));

    }else if (_storage.runtimeType.toString().isNotEmpty && widget.city != '') {
      BlocProvider.of<WeatherBloc>(context)
          .add(WeatherRequested(city: widget.city));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) => WeatherBloc(),
      child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is WeatherLoadSuccess) {
          return Scaffold(
            backgroundColor: Colors.blue,
            body: SafeArea(
              child: WeatherWidgetElements(
                  weather: state.weather, hourlyWeather: state.hourlyWeather),
            ),
          );
        } else if (state is WeatherLoadFailure) {
          return Scaffold(
            body: Center(
              child: TextButton(onPressed: () {
                Navigator.of(context).pushNamed(MainNavigationRouteNames.searchScreen);
              }, child: Text('Ошибка сетиб вернутся на главную'),),
            ),
          );
        }else if (state is WeatherInitial) {
          return Scaffold(
            body: Center(
              child: TextButton(onPressed: () {
                Navigator.of(context).pushNamed(MainNavigationRouteNames.searchScreen);
              }, child: Text('Ошибка вернутся на главную'),),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }),
    );
  }
}
