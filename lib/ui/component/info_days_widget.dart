import 'package:flutter/material.dart';
import 'package:weather_app_flutter/domain/entity/hours_weather.dart';
import 'package:weather_app_flutter/domain/entity/weather.dart';

class InfoDaysWidget extends StatelessWidget {
  final Weather weather;
  final List<WeatherHours> hourlyWeather;
  const InfoDaysWidget({Key? key, required this.weather, required this.hourlyWeather})
      : super(key: key);

  final style =const TextStyle(fontSize: 18, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600],
          borderRadius:const BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                'Forecast for 3 days',
                style: style,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Text(
                      'Time',
                      style: style,
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text('t°', style: style)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text('Hum', style: style)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text('Pres', style: style)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text('Wind', style: style)),
                  Expanded(child: Text('', style: style)),
                ],
              ),
            ),
            const Divider(
              height: 3,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: WeatherTable(
                weather: weather,
                hourlyWeather: hourlyWeather,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherTable extends StatelessWidget {
  final Weather weather;
  final List<WeatherHours> hourlyWeather;
  const WeatherTable(
      {super.key, required this.weather, required this.hourlyWeather});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return WeatherCard(
            weather: weather,
            hourlyWeather: hourlyWeather,
            index: index,
          );
        });
  }
}

class WeatherCard extends StatelessWidget {
  final int index;
  final Weather weather;
  final List<WeatherHours> hourlyWeather;
  WeatherCard(
      {Key? key,
        required this.weather,
        required this.hourlyWeather,
        required this.index})
      : super(key: key);
  final style = TextStyle(fontSize: 18, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
          child: Text(
              '${hourlyWeather[index].time.hour}:${hourlyWeather[index].time.minute}',
              style: style),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text('${hourlyWeather[index].temperature}°', style: style)),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text('${hourlyWeather[index].humidity}%', style: style)),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text('${hourlyWeather[index].pressure}°', style: style)),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
          child: Row(
            children: [
              Text('${hourlyWeather[index].wind}°', style: style),
              Text('->', style: style),
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 20,
            width: 20,
            child: Image.network(
                "http://openweathermap.org/img/wn/${hourlyWeather[index].iconCode}@2x.png",
                scale: 3),
          ),
        ),
      ],
    );
  }
}