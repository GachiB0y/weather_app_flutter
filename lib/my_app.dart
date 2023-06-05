import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather_app_flutter/ui/navigation/main_navigation.dart';
import 'package:weather_app_flutter/ui/navigation/main_navigation_route_name.dart';



abstract class MainNavigation {
  Map<String, Widget Function(BuildContext)> makeRoute();
  Route<Object> onGenerateRoute(RouteSettings settings);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final MainNavigation mainNavigation = MainNavigationDefault();
  final _storage = HydratedBloc.storage;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: _storage.runtimeType.toString().isNotEmpty == true ? MainNavigationRouteNames.mainScreen : MainNavigationRouteNames.searchScreen,
      // initialRoute: HydratedBloc.storage.read('weather').toString().isNotEmpty == true ? MainNavigationRouteNames.mainScreen : MainNavigationRouteNames.searchScreen,
      routes: mainNavigation.makeRoute(),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
