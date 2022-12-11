// import 'package:flutter/material.dart';

// import 'package:restaurant_app_3/model/database/database_helper.dart';
// import 'package:restaurant_app_3/model/data/restaurant_detail.dart';

// enum ResultStateDatabase { loading, noData, hashData, error }

// class DatabaseProvider extends ChangeNotifier {
//   late DatabaseHelper databaseHelper;

//   late bool _isFavorite = false;
//   late List<Restaurant> _restaurantFavorite;
//   late ResultStateDatabase _stateDatabaseRestaurant;
//   // late String _messageDatabaseRestaurant = '';

//   bool get isFavorite => _isFavorite;

//   List<Restaurant> get restaurantFavoriteList => _restaurantFavorite;

//   ResultStateDatabase get stateDatabaseRestaurant => _stateDatabaseRestaurant;
//   // String get messageDatabaseRestaurant => _messageDatabaseRestaurant;

//   DatabaseProvider() {
//     getFetchAllRestaurantFavorite();
//   }

//   void getFetchAllRestaurantFavorite() async {
//     try {
//       _stateDatabaseRestaurant = ResultStateDatabase.loading;
//       List<Restaurant> dataRestaurantDetailFavorite =
//           await databaseHelper.getRestaurantFavorite();
//       if (dataRestaurantDetailFavorite.isNotEmpty) {
//         _restaurantFavorite = dataRestaurantDetailFavorite;
//         _stateDatabaseRestaurant = ResultStateDatabase.hashData;
//         notifyListeners();
//       } else {
//         _stateDatabaseRestaurant = ResultStateDatabase.noData;
//         notifyListeners();
//       }
//     } catch (e) {
//       _stateDatabaseRestaurant = ResultStateDatabase.error;
//       notifyListeners();
//     }
//   }

// // on SocketException {
// //       _stateDatabaseRestaurant = ResultStateDatabase.error;
// //       notifyListeners();
// //       // return _messageDatabaseRestaurant =
// //       //     'Maaf Coba Periksa Koneksi Internet Anda!!!';
// //     }

//   void addFavoriteList(Restaurant restaurant) async {
//     try {
//       await databaseHelper.insertDataRestaurantFavorite(restaurant);
//       getFetchAllRestaurantFavorite();
//       _isFavorite = true;
//       notifyListeners();
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<bool> isFavoriteRestaurant(String id) async {
//     _stateDatabaseRestaurant = ResultStateDatabase.loading;
//     final keluaran = await databaseHelper.getRestaurantFavoriteById(id);
//     bool resultValue = keluaran.isNotEmpty;
//     _isFavorite = resultValue;
//     _stateDatabaseRestaurant = ResultStateDatabase.hashData;
//     notifyListeners();
//     return resultValue;
//   }

//   Future<void> removeFavoriteList(String id) async {
//     try {
//       _stateDatabaseRestaurant = ResultStateDatabase.loading;
//       await databaseHelper.deleteRestaurantFavorite(id);
//       _isFavorite = false;
//       getFetchAllRestaurantFavorite();
//       _stateDatabaseRestaurant = ResultStateDatabase.hashData;
//       notifyListeners();
//     } catch (e) {
//       _stateDatabaseRestaurant = ResultStateDatabase.error;
//       notifyListeners();
//       print(e);
//     }
//   }
// }
