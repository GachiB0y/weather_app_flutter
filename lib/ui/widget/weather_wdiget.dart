import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_flutter/domain/blocs/weather_bloc.dart';
import 'package:weather_app_flutter/domain/blocs/weather_event.dart';
import 'package:weather_app_flutter/domain/blocs/weather_state.dart';
import 'package:weather_app_flutter/domain/entity/hours_weather.dart';
import 'package:weather_app_flutter/domain/entity/weather.dart';

class WeatherWidget extends StatelessWidget {
  WeatherWidget({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    

    return BlocProvider<WeatherBloc>(
        create: (context) => WeatherBloc('moscow'),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
              if ( state is WeatherLoadSuccess) {
                return Scaffold(
                  backgroundColor: Colors.blue,
                  body: SafeArea(
                    child: WeatherWidgetElements(weather: state.weather, hourlyWeather: state.hourlyWeather),
                  ),
                );
              }else if(state is WeatherLoadFailure) {
                return Scaffold(
                  body: Center(
                    child: Text('Ошибка сети'),
                  ),
                );
              } else {
                  return Scaffold(
                        body: Center(
                              child: ElevatedButton(
                                  onPressed: (){
                                    print({state});
                                    BlocProvider.of<WeatherBloc>(context).add(WeatherRequested(city: 'moscow'));
                                  },
                                  child: Text('Get the weather forecast',style:TextStyle(fontSize: 20,color:Colors.black))),
                            ),
                          );
                  }
          }
    ),
    );
  }
}

class WeatherWidgetElements extends StatelessWidget {
  final Weather weather;
  final List<WeatherHours> hourlyWeather;
  const WeatherWidgetElements({Key? key, required this.weather, required this.hourlyWeather}) : super(key: key);

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
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      weatherBlocAction.add(WeatherRequested(city: 'moscow'));
                    }, 
                    child: Text('Back', style: TextStyle(color: Colors.black,fontSize: 20),)
                ),
                Text('${city}',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                Text('${time.hour} : ${time.minute}',style: TextStyle(color: Colors.black,fontSize: 20),)
              ],),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Text('${description}',style: TextStyle(fontSize: 24,),),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network("http://openweathermap.org/img/wn/${iconId}@2x.png", scale: 0.8),
              Text('${temp}° C',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
            ],),
          Text('Feels like ${feels}° C',style: TextStyle(fontSize: 20,),),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          InfoNameWidget(weather: weather, hourlyWeather: hourlyWeather,),
          Expanded(child: FlutterLogo(size: 200,)),
          InfoDaysWidget(),
        ],
      ),
    );
  }
}


class InfoNameWidget extends StatelessWidget {
  InfoNameWidget({Key? key, required this.weather, required this.hourlyWeather}) : super(key: key);
  final Weather weather;
  final List<WeatherHours> hourlyWeather;
   final listItemName = {
     1:"Humidity",
     2:"Pressure",
     3:"Wind",
   };
  @override
  Widget build(BuildContext context) {
    final listItemInfo = {
      1:weather.humidity,
      2:weather.pressure,
      3:weather.wind,
    };
    return Container(
      width: 200,
      height: 100,
      child: ListView.builder(
        itemCount: listItemName.length,
        itemBuilder: (BuildContext context, int index) {
          return  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${listItemName[index + 1]}',style: TextStyle(fontSize: 20,),),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${listItemInfo[index + 1]}',style: TextStyle(fontSize: 20,),),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}



class InfoDaysWidget extends StatelessWidget {
  InfoDaysWidget({Key? key}) : super(key: key);

  final style = TextStyle(fontSize: 18,color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[900],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
        ),
        ),

        // height: 200,
        // width: 411,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:12.0),
              child: Text('Forecast for 3 days',style: style,),
            ),
            SizedBox(height: 4,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Time',style: style,),
                Text('t°',style:style),
                Text('Hum',style:style),
                Text('Pres',style:style),
                Text('Wind',style:style),
              ],
            ),
             ItemDays(),
          ],
        ),
      ),
    );
  }
}

class ItemDays extends StatelessWidget {
  ItemDays({Key? key}) : super(key: key);

  final style = TextStyle(fontSize: 18,color: Colors.white);
  final listItemInfo = {
    1:"A",
    2:"B",
    3:"C",
    4:"D",
    5:"E",
    6:"F",
    7:"G",
  };
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return  Container(
           height: 35,
          child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('${listItemInfo[index + 1]}',style: style,),
              Text('${listItemInfo[index + 1]}',style: style,),
              Text('${listItemInfo[index + 1]}',style: style,),
              Text('${listItemInfo[index + 1]}',style: style,),
              Text('${listItemInfo[index + 1]}',style: style,),
              Text('${listItemInfo[index + 1]}',style: style,),
              Text('${listItemInfo[index + 1]}',style: style,),
            ],
          ),
        );
      },
    );
  }
}




