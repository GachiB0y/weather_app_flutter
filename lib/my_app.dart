import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_flutter/domain/blocs/search_cubit.dart';
import 'package:weather_app_flutter/ui/widget/city_search_wdiget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<SearchViewCubit>(
        create: (context) => SearchViewCubit(),
        child: CitySearchWidget(),
      ),
    );
  }
}
