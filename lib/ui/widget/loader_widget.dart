import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_flutter/domain/blocs/loader_cubit.dart';
import 'package:weather_app_flutter/ui/navigation/main_navigation_route_name.dart';



class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderViewCubit,LoaderViewCubitState>(
      listenWhen: (prev, current) => current!= LoaderViewCubitState.unknown,
      listener: (context,state){
        _onLoaderViewCubitStateChange(context,state);
      },
      child: const Scaffold(
        body: Center(
          child: Text('Лоадер Виджет'),
        ),
      ),
    );
  }

  void _onLoaderViewCubitStateChange(BuildContext context,LoaderViewCubitState state ){
    final nextScreen = state == LoaderViewCubitState.authorized
        ? MainNavigationRouteNames.mainScreen
        :MainNavigationRouteNames.searchScreen;
    Navigator.of(context).popAndPushNamed(nextScreen);
  }

}