import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

enum LoaderViewCubitState{
  authorized,notAuthorized,unknown
}

abstract class LoaderViewModelAuthStatusProvider{
  Future<bool> isAuth();
}

class LoaderViewCubit extends Cubit<LoaderViewCubitState>{


  LoaderViewCubit () : super(LoaderViewCubitState.unknown){
    asyncInit();
  }

  void asyncInit() {
     checkAuth();
  }

  void checkAuth()  {
    final _storage = HydratedBloc.storage;
    final isAuth = _storage.runtimeType.toString().isNotEmpty;
    isAuth ?  emit(LoaderViewCubitState.authorized) : emit(LoaderViewCubitState.notAuthorized);
  }
}