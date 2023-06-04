import 'package:flutter/material.dart';
import 'package:weather_app_flutter/domain/entity/hours_weather.dart';
import 'package:weather_app_flutter/domain/entity/weather.dart';
import 'package:weather_app_flutter/ui/component/icon_painter_widget.dart';
import 'package:weather_app_flutter/ui/component/info_days_widget.dart';
import 'package:weather_app_flutter/ui/component/info_name_widget.dart';
import 'package:weather_app_flutter/ui/navigation/main_navigation_route_name.dart';


class WeatherWidgetElements extends StatelessWidget {
  final Weather weather;
  final List<WeatherHours> hourlyWeather;
  const WeatherWidgetElements(
      {Key? key, required this.weather, required this.hourlyWeather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final city = weather.cityName;
    final time = weather.time;
    final description = weather.description;
    final iconId = weather.iconCode;
    final temp = weather.temperature;
    final feels = weather.feelsLike;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(MainNavigationRouteNames.searchScreen);
                    },
                    child:const Text(
                      'Back',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                Text(
                  '${city}',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${time.hour} : ${time.minute}',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            '${description}',
            style:const TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network("http://openweathermap.org/img/wn/${iconId}@2x.png",
                  scale: 0.8),
              Text(
                '${temp}° C',
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            'Feels like ${feels}° C',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Expanded(
            child: InfoNameWidget(
              weather: weather,
              hourlyWeather: hourlyWeather,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            child:const  CustomPaint(
              painter: IconPainterWidget(),
              size: Size(200, 200),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          InfoDaysWidget(
            hourlyWeather: hourlyWeather,
            weather: weather,
          ),
        ],
      ),
    );
  }
}