import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:restaurant_app_3/model/data/restaurant_detail.dart';
import 'package:restaurant_app_3/model/data/restaurant_list.dart';

class DatabaseHelper {
  static DatabaseHelper? _instanceDatabaseRestaurant;
  static Database? _databaseRestaurant;

  DatabaseHelper._internal() {
    _instanceDatabaseRestaurant = this;
  }

  factory DatabaseHelper() =>
      _instanceDatabaseRestaurant ?? DatabaseHelper._internal();

  static const String _tabelRestaurantFavorite = 'restaurant_favorite';

  Future<Database> _restaurantDatabase() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/restaurant.db', onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $_tabelRestaurantFavorite (
          id TEXT PRIMARY KEY NOT NULL,
          name TEXT NOT NULL,
          pictureId TEXT NOT NULL,
          description TEXT NOT NULL,
          city TEXT NOT NULL,
          rating FLOAT NOT NULL
        )
      ''');
    }, version: 1);
    return db;
  }

  Future<Database?> get databaseRestaurant async {
    if (_databaseRestaurant == null) {
      _databaseRestaurant = await _restaurantDatabase();
    }
    return _databaseRestaurant;
  }

  Future<List<Restaurant1>> getRestaurantFavorite() async {
    final db = await databaseRestaurant;
    List<Map<String, dynamic>> resultsDatabaseRestaurant =
        await db!.query(_tabelRestaurantFavorite);

    return resultsDatabaseRestaurant
        .map((e) => Restaurant1.fromMap(e))
        .toList();
  }

  Future<void> insertDataRestaurantFavorite(
      Restaurant1 restaurantDataFavorite) async {
    final db = await databaseRestaurant;
    await db!.insert(_tabelRestaurantFavorite, restaurantDataFavorite.toMap());
  }

  Future<Map> getRestaurantFavoriteById(String id) async {
    final db = await databaseRestaurant;
    List<Map<String, dynamic>> resultsDatabaseRestaurant = await db!
        .query(_tabelRestaurantFavorite, where: 'id = ?', whereArgs: [id]);

    if (resultsDatabaseRestaurant.isNotEmpty) {
      return resultsDatabaseRestaurant.first;
    } else {
      return {};
    }
  }

  Future<void> deleteRestaurantFavorite(String id) async {
    final db = await databaseRestaurant;
    await db!
        .delete(_tabelRestaurantFavorite, where: 'id = ?', whereArgs: [id]);
  }
}
