import 'dart:async';
import '../view_model/restaurantItem.dart';
import '../repository/restaurantRepository.dart';

class restaurantItemBloc{
  late List<restaurantItem> m_restaurantList = [];
  static double latitude = 37.523327 ;
  static double longitude = 126.921252;
  static double mapZoom = 15;

  final StreamController<List<restaurantItem>> _restaurantListSubject =
  StreamController<List<restaurantItem>>.broadcast();
  Stream<List<restaurantItem>> get restaurantList => _restaurantListSubject.stream;

  // 에러 상태
  final StreamController<String> _errorMessageSubject =
  StreamController<String>.broadcast();
  Stream<String> get errorMessage => _errorMessageSubject.stream;

  final restaurantRepository _repository = restaurantRepository();

  void setLatLngZoom(double lat, double lng, double zoom){
    latitude = lat;
    longitude = lng;
    mapZoom = zoom;
  }

  void listUpItems() async {

    print('listUpItems !!!');

    try {
      m_restaurantList = await _repository.fetchRestaurantItem(latitude, longitude, mapZoom);

      _restaurantListSubject.sink.add(m_restaurantList);
    } catch (ex) {
      final String errorMessage = ex.toString();
      _errorMessageSubject.sink.add(errorMessage);
    }
  }

  void dispose() {
    _restaurantListSubject.close();
    _errorMessageSubject.close();
  }
}