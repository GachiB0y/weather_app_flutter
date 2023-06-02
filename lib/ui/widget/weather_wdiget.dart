import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_flutter/domain/blocs/weather_bloc.dart';
import 'package:weather_app_flutter/domain/blocs/weather_event.dart';
import 'package:weather_app_flutter/domain/blocs/weather_state.dart';
import 'package:weather_app_flutter/domain/entity/hours_weather.dart';
import 'package:weather_app_flutter/domain/entity/weather.dart';

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

  @override
  void initState() {
    BlocProvider.of<WeatherBloc>(context)
        .add(WeatherRequested(city: widget.city));
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
              child: Text('Ошибка сети'),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }),
    );
  }
}

class WeatherWidgetElements extends StatelessWidget {
  final Weather weather;
  final List<WeatherHours> hourlyWeather;
  const WeatherWidgetElements(
      {Key? key, required this.weather, required this.hourlyWeather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBlocAction = context.read<WeatherBloc>();
    final WeatherBloc weatherBloc = context.watch<WeatherBloc>();
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
                      Navigator.pop(context);
                    },
                    child: Text(
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
            style: TextStyle(
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
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            'Feels like ${feels}° C',
            style: TextStyle(
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
            child: CustomPaint(
              painter: MyIconPainter(),
              size: const Size(180, 180),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
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
      width: 250,
      height: 100,
      child: ListView.builder(
        itemCount: listItemName.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${listItemName[index + 1]}',
                      style: TextStyle(
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
                      style: TextStyle(
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

class InfoDaysWidget extends StatelessWidget {
  final Weather weather;
  final List<WeatherHours> hourlyWeather;
  InfoDaysWidget({Key? key, required this.weather, required this.hourlyWeather})
      : super(key: key);

  final style = TextStyle(fontSize: 18, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600],
          borderRadius: BorderRadius.only(
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
            SizedBox(
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
            Divider(
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
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
          child: Text(
              '${hourlyWeather[index].time.hour} : ${hourlyWeather[index].time.minute}',
              style: style),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text('${hourlyWeather[index].temperature} °', style: style)),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text('${hourlyWeather[index].humidity} %', style: style)),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text('${hourlyWeather[index].pressure} °', style: style)),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
          child: Row(
            children: [
              Text('${hourlyWeather[index].wind} °', style: style),
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

class MyIconPainter extends CustomPainter {
  const MyIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radiusGrow = size.width / 2;

    final dotPainter = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.0;
    final dotPainter2 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.0;
    final linesPainter = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;
    final linesPainter2 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    canvas.drawCircle(Offset(centerX, centerY), radiusGrow, dotPainter);
    canvas.drawCircle(Offset(centerX, centerY), radiusGrow - 4, dotPainter2);
    canvas.drawLine(
        Offset(
          0,
          centerY,
        ),
        Offset(
          centerX * 2,
          centerY,
        ),
        linesPainter);
    canvas.drawLine(
        Offset(
          centerX,
          0,
        ),
        Offset(
          centerX,
          centerY * 2,
        ),
        linesPainter);

    canvas.drawLine(
        Offset(
          centerX - (radiusGrow * (sqrt(2) / 2)),
          centerY + (radiusGrow * (sqrt(2) / 2)),
        ),
        Offset(
          centerX + (radiusGrow * (sqrt(2) / 2)),
          centerY - (radiusGrow * (sqrt(2) / 2)),
        ),
        linesPainter2);

    canvas.drawLine(
        Offset(
          centerX + (radiusGrow * (sqrt(2) / 2)),
          centerY - (radiusGrow * (sqrt(2) / 2)),
        ),
        Offset(
          centerX + ((3 / 4) * radiusGrow * cos(1.18)),
          centerY - ((3 / 4) * radiusGrow * sin(1.18)),
        ),
        linesPainter2);

    canvas.drawLine(
        Offset(
          centerX + (radiusGrow * (sqrt(2) / 2)),
          centerY - (radiusGrow * (sqrt(2) / 2)),
        ),
        Offset(
          centerX + ((3 / 4) * radiusGrow * cos(0.39)),
          centerY - ((3 / 4) * radiusGrow * sin(0.39)),
        ),
        linesPainter2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
