import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'MainPage.dart';

import '../component/google_map.dart';
import '../bloc/business_logic.dart';
import '../view_model/restaurantItem.dart';

class MainMapPage extends StatelessWidget {
  final restaurantItemBloc _itemBloc = MainPage.itemBloc;

  Future<String> checkPermission() async{
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if(!isLocationEnabled){
      return 'Please activate location service';
    }

    LocationPermission checkedPermission = await Geolocator.checkPermission();

    if(checkedPermission == LocationPermission.denied){
      checkedPermission = await Geolocator.requestPermission();

      if(checkedPermission == LocationPermission.denied){
        return 'Please grant location service';
      }
    }

    if(checkedPermission == LocationPermission.deniedForever){
      return 'Please grant location service in setting menu';
    }

    return 'Location service activated';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<String>(
        future: checkPermission(),
        builder: (context, snapshot){
          if(!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if( snapshot.data == 'Location service activated'){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: GoogleMapApp()),

                  Container(
                      height: MediaQuery.of(context).size.height/4,
                      child: StreamBuilder(
                        stream: _itemBloc.restaurantList,
                        initialData: [],
                        builder: (_, snapshot) {
                          return ListView.separated(
                              //scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                final item = snapshot.data![index] as restaurantItem;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Text(
                                              item.placeName,
                                              style: const TextStyle(
                                                  fontSize: 20, fontWeight: FontWeight.bold),
                                            )),
                                      ],
                                    ),
                                    Text(
                                      item.placeUrl,
                                      style:
                                      const TextStyle(fontSize: 16, color: Colors.grey),
                                    )
                                  ],
                                );
                              },
                              separatorBuilder: (_, index) => const Divider(),
                              itemCount: snapshot.data!.length);
                        },
                      )
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Text(
              snapshot.data.toString(),
            ),
          );
        }
      ),
    );
  }
}
