import 'package:flutter/material.dart';

import 'package:restaurant_app_3/model/data/restaurant_detail.dart';
import 'package:restaurant_app_3/model/data/restaurant_list.dart';
import 'package:restaurant_app_3/model/database/database_helper.dart';

enum ResultStateDatabase { loading, error, noData, hasData }

class RestaurantDatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelperRestaurant;

  RestaurantDatabaseProvider({required this.databaseHelperRestaurant}) {
    _getRestaurantFavorite();
  }

  ResultStateDatabase _stateDatabase = ResultStateDatabase.loading;
  ResultStateDatabase get stateDatabase => _stateDatabase;
  String _message = '';
  String get message => _message;

  List<Restaurant1> _restaurantFavorite = [];
  List<Restaurant1> get restaurantFavorite => _restaurantFavorite;

  void _getRestaurantFavorite() async {
    _restaurantFavorite =
        await databaseHelperRestaurant.getRestaurantFavorite();
    if (_restaurantFavorite.isNotEmpty) {
      _stateDatabase = ResultStateDatabase.hasData;
      notifyListeners();
    } else {
      _stateDatabase = ResultStateDatabase.noData;
      _message = 'Data Kosong';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant1 restaurant) async {
    try {
      await databaseHelperRestaurant.insertDataRestaurantFavorite(restaurant);
      _getRestaurantFavorite();
      notifyListeners();
    } catch (e) {
      _stateDatabase = ResultStateDatabase.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelperRestaurant.deleteRestaurantFavorite(id);
      _getRestaurantFavorite();
      notifyListeners();
    } catch (e) {
      _stateDatabase = ResultStateDatabase.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final restaurant =
        await databaseHelperRestaurant.getRestaurantFavoriteById(id);
    return restaurant.isNotEmpty;
  }
}
