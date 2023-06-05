
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_flutter/domain/blocs/loader_cubit.dart';
import 'package:weather_app_flutter/domain/blocs/search_cubit.dart';
import 'package:weather_app_flutter/my_app.dart';
import 'package:weather_app_flutter/ui/navigation/main_navigation_route_name.dart';
import 'package:weather_app_flutter/ui/widget/city_search_wdiget.dart';
import 'package:weather_app_flutter/ui/widget/loader_widget.dart';

import '../widget/weather_wdiget.dart';

abstract class ScreenFactory {
  Widget makeSlotMachineScreen();
  Widget makeCaseCsGoScreen();
}

class MainNavigationDefault implements MainNavigation {

  MainNavigationDefault();

  @override
  Map<String, Widget Function(BuildContext)> makeRoute() =>
      <String, Widget Function(BuildContext)>{
        MainNavigationRouteNames.searchScreen: (_) {
          return
          BlocProvider<SearchViewCubit>(
              create: (context) => SearchViewCubit(),
          child: CitySearchWidget());
        },
        MainNavigationRouteNames.loaderWidget: (_) {
         return BlocProvider<LoaderViewCubit>(
              create: (context) => LoaderViewCubit(),
              child: LoaderWidget(),
              lazy: false,
         );

        },
  }
;

  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.mainScreen:
        final arg = settings.arguments;
        final cityName = arg is String ? arg : '';
        return MaterialPageRoute(builder: (_) => WeatherWidget.create(
            cityName));
      default:
        const widget = Text('Navigation error!!');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }
}