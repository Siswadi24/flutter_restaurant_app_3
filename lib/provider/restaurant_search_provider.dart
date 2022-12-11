import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app_3/model/api/api_service.dart';
import 'package:restaurant_app_3/model/data/restaurant_search.dart';

enum ResultStateSearch { loading, noData, hashData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService}) {
    getSearchRestaurants(queryResult);
  }

  RestaurantResulSearch? _restaurantResultListSearch;
  ResultStateSearch? _stateListRestaurantSearch;
  String _messageListRestaurantSeacrh = '';
  String _query = '';

  RestaurantResulSearch? get restaurantResultListSearch =>
      _restaurantResultListSearch;
  ResultStateSearch? get stateListRestaurantSearch =>
      _stateListRestaurantSearch;
  String get messageListRestaurantSearch => _messageListRestaurantSeacrh;
  String get queryResult => _query;

  Future<dynamic> getSearchRestaurants(String queryResult) async {
    try {
      if (queryResult.isNotEmpty) {
        _stateListRestaurantSearch = ResultStateSearch.loading;
        _query = queryResult;
        notifyListeners();
        final responseSearchRestaurant =
            await apiService.getSearchRestaurant(queryResult);
        if (responseSearchRestaurant.restaurants.isEmpty) {
          _stateListRestaurantSearch = ResultStateSearch.noData;
          notifyListeners();
          return _messageListRestaurantSeacrh =
              'Mohon Maaf Data Tidak Ditemukan';
        } else {
          _stateListRestaurantSearch = ResultStateSearch.hashData;
          notifyListeners();
          return _restaurantResultListSearch = responseSearchRestaurant;
        }
      } else {
        return _messageListRestaurantSeacrh = 'text tidak diketahui';
      }
    } on SocketException {
      _stateListRestaurantSearch = ResultStateSearch.error;
      notifyListeners();
      return _messageListRestaurantSeacrh =
          'Maaf Koneksi Anda Bermasalah, Mohon Periksa Koneksi Anda!!';
    } catch (e) {
      _stateListRestaurantSearch = ResultStateSearch.error;
      notifyListeners();
      return _messageListRestaurantSeacrh =
          'Error diakibatkan oleh ' + e.toString();
    }
  }
}

  // void SearchPagesName(String query) {
  //   _query = query;
  //   _getSearchRestaurant();
  // }