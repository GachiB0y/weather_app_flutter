import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_flutter/domain/blocs/search_cubit.dart';
import 'package:weather_app_flutter/domain/blocs/weather_bloc.dart';
import 'package:weather_app_flutter/domain/blocs/weather_event.dart';
import 'package:weather_app_flutter/ui/widget/weather_wdiget.dart';

class CitySearchWidget extends StatelessWidget {
  CitySearchWidget({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(
          top: 15,
          bottom: 15,
        )),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
                side: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ))));
    final cubit = context.watch<SearchViewCubit>();
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const Text(
                'Weather',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  onTap: () {},
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'City',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              cubit.state.itemsGet.isNotEmpty == true
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: cubit.state.itemsGet.length,
                        itemBuilder: (context, index) {
                          print('cubit:${cubit.state.itemsGet}');
                          return BlocListener<SearchViewCubit, SearchViewState>(
                            listener: (context, state) => WeatherBloc(),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              // color: Colors.grey[300],
                              child: ListTile(
                                title: Text(cubit.state.itemsGet[index]),
                                onTap: () {
                                  searchController.text =
                                      cubit.state.itemsGet[index];
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: style,
                      onPressed: () {
                        cubit.createListItems(searchController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WeatherWidget.create(
                                    searchController.text)));
                      },
                      child: const Text('Get the weather forecast',
                          style: TextStyle(fontSize: 20, color: Colors.black))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
