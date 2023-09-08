import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:math';
import 'dart:convert';
import '../view_model/restaurantItem.dart';

class restaurantRepository {
  Future<List<restaurantItem>> fetchRestaurantItem(double lat, double lng, double zoom ) async{

    // zoom level 14 => 3000 m
    // 15 => 3000/2
    // 16 => 3000/4
    // 17 => 3000/8

    if ( zoom < 14 ) zoom = 14;
    double pow_zoom = zoom - 13;

    final latitude = lat.toStringAsFixed(6);
    final longitude = lng.toStringAsFixed(6);
    final radius = 6000 / pow(2, pow_zoom);

    print("fetchRestaurantItem Latitude: " + latitude + " " + "Longitude: " + longitude);

    final url = "https://dapi.kakao.com/v2/local/search/category.json?x=" + lng.toStringAsFixed(6) + "&y=" + lat.toStringAsFixed(6) + "&category_group_code=FD6&radius=" + radius.toString();
    print(url);

    try {
      http.Response _response = await http.get(
          Uri.parse(url),
          headers: {
            "Authorization" : "KakaoAK 3bbbe2d581ebec3409f5c5f899d2313e",
          });
      if (_response.statusCode == 200) {
        print(_response.body);
        Map<String, dynamic> _fromMap = json.decode(_response.body);
        List<dynamic> _data = List.from(_fromMap["documents"]);
        List<restaurantItem> _return = _data.map((e) {
          String placeName = e["place_name"];
          String place_url = e["place_url"];
          print('placeName :' + placeName);
          return restaurantItem(placeName: placeName, placeUrl: place_url);
        }).toList();
        return _return;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }
}
