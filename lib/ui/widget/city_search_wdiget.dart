import 'package:flutter/material.dart';

class CitySearchWidget extends StatelessWidget {
   CitySearchWidget({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

   final style =  ButtonStyle(
       padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(top:15,bottom: 15,)),
     backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
                side: BorderSide( width: 0,
                  style: BorderStyle.none,)
            )
        )
    );

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            Text('Weather',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Padding(
                padding: const EdgeInsets.only(left:20.0,right: 20.0),
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'City',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: style,
                      onPressed: (){},
                      child: Text('Get the weather forecast',style:TextStyle(fontSize: 20,color:Colors.black))),
                ),
              )
          ],
          ),
        ),
      ),
    );
  }
}
