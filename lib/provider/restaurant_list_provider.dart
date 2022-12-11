import 'dart:io';
import 'package:flutter/material.dart';

import 'package:restaurant_app_3/model/api/api_service.dart';
import 'package:restaurant_app_3/model/data/restaurant_list.dart';

enum ResultState { loading, noData, hashData, error }

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _getFetchAllRestaurant();
  }

  late RestaurantResult _restaurantResultList;
  late ResultState _stateListRestaurant;
  String _messageListRestaurant = '';

  RestaurantResult get restaurantResultList => _restaurantResultList;
  ResultState get stateListRestaurant => _stateListRestaurant;
  String get messageListRestaurant => _messageListRestaurant;

  Future<dynamic> _getFetchAllRestaurant() async {
    try {
      _stateListRestaurant = ResultState.loading;
      notifyListeners();
      final restaurantResponseList = await apiService.getListRestaurant();
      if (restaurantResponseList.restaurantss.isEmpty) {
        _stateListRestaurant = ResultState.noData;
        notifyListeners();
        return _messageListRestaurant = 'Data Kosong...???';
      } else {
        _stateListRestaurant = ResultState.hashData;
        notifyListeners();
        return _restaurantResultList = restaurantResponseList;
      }
    } on SocketException {
      _stateListRestaurant = ResultState.error;
      notifyListeners();
      return _messageListRestaurant =
          'Maaf Coba Periksa Koneksi Internet Anda!!!';
    } catch (e) {
      _stateListRestaurant = ResultState.error;
      notifyListeners();
      return _messageListRestaurant = 'Error Akibat ' + e.toString();
    }
  }
}
