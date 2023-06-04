import 'package:flutter/material.dart';
import 'package:weather_app_flutter/domain/entity/hours_weather.dart';
import 'package:weather_app_flutter/domain/entity/weather.dart';


class InfoNameWidget extends StatelessWidget {
  InfoNameWidget({Key? key, required this.weather, required this.hourlyWeather})
      : super(key: key);
  final Weather weather;
  final List<WeatherHours> hourlyWeather;
  final listItemName = {
    1: "Humidity",
    2: "Pressure",
    3: "Wind",
  };
  @override
  Widget build(BuildContext context) {
    final listItemInfo = {
      1: '${weather.humidity}%',
      2: '${weather.pressure} mmHg',
      3: '${weather.wind} m/s',
    };
    return Container(
      width: 240,
      height: 100,
      child: ListView.builder(
        itemCount: listItemName.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.28,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${listItemName[index + 1]}',
                      style:const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${listItemInfo[index + 1]}',
                      style:const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}