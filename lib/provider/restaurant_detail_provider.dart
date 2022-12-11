import 'dart:io';
import 'package:flutter/material.dart';

import 'package:restaurant_app_3/model/api/api_service.dart';
import 'package:restaurant_app_3/model/data/restaurant_detail.dart';

enum ResultStateDetail { loading, noData, hashData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({
    required this.apiService,
    required this.id,
  }) {
    getDetailRestaurants(id);
  }

  RestaurantDetail? _restaurantResultDetail;
  ResultStateDetail? _stateDetailRestaurant;
  String _messageDetailRestaurant = '';

  RestaurantDetail? get restaurantResultDetail => _restaurantResultDetail;
  ResultStateDetail? get stateDetailRestaurant => _stateDetailRestaurant;
  String get messageDetailRestaurant => _messageDetailRestaurant;

  Future<dynamic> getDetailRestaurants(String id) async {
    try {
      _stateDetailRestaurant = ResultStateDetail.loading;
      notifyListeners();
      final detailRestaurant = await apiService.getDetailRestaurantId(id);
      if (detailRestaurant.error) {
        _stateDetailRestaurant = ResultStateDetail.noData;
        notifyListeners();
        return _messageDetailRestaurant = 'Data Tidak Ditemukan';
      } else {
        _stateDetailRestaurant = ResultStateDetail.hashData;
        notifyListeners();
        return _restaurantResultDetail = detailRestaurant;
      }
    } on SocketException {
      _stateDetailRestaurant = ResultStateDetail.error;
      notifyListeners();
      return _messageDetailRestaurant =
          'Maaf Koneksi Anda Bermasalah, Mohon Periksa Koneksi Anda!!';
    } catch (e) {
      _stateDetailRestaurant = ResultStateDetail.error;
      notifyListeners();
      return _messageDetailRestaurant =
          'Error diakibatkan oleh ' + e.toString();
    }
  }
}
