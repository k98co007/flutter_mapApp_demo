import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/business_logic.dart';
import '../view_model/restaurantItem.dart';
import '../page/MainPage.dart';

class GoogleMapApp extends StatelessWidget{
  static final restaurantItemBloc _itemBloc = MainPage.itemBloc;

  static final LatLng myLatLng = LatLng(
    37.5233273,
    126.921252
  );

  static final Marker marker = Marker(
      markerId: MarkerId('myLatLng'), position: myLatLng);

  const GoogleMapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: myLatLng,
          zoom: 16,
        ),
        myLocationEnabled: true,
        markers: Set.from([marker]),
        onCameraIdle: () {
          print('onCameraIdle !!!');
          _itemBloc.listUpItems();
        },
        onCameraMove: (CameraPosition position) {
          print("Latitude: ${position.target.latitude}; Longitude: ${position.target.longitude}");
          _itemBloc.setLatLngZoom(position.target.latitude, position.target.longitude, position.zoom);
        },
      ),
    );
  }
}