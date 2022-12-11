import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app_3/model/data/restaurant_detail.dart';
import 'package:restaurant_app_3/model/data/restaurant_list.dart';
import 'package:restaurant_app_3/model/data/restaurant_search.dart';

class ApiService {
  static const _apiUrlRestaurant = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResult> getListRestaurant() async {
    final response = await http.get(Uri.parse('${_apiUrlRestaurant}list'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromMap(json.decode(response.body));
    } else {
      throw Exception('Gagal Mengambil Data dari Headlines');
    }
  }

  Future<RestaurantResulSearch> getSearchRestaurant(String query) async {
    final response =
        await http.get(Uri.parse("${_apiUrlRestaurant}search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantResulSearch.fromMap(json.decode(response.body));
    } else {
      throw Exception('Gagal Mengambil Data Dari Headlines Seacrh');
    }
  }

  Future<RestaurantDetail> getDetailRestaurantId(String id) async {
    final response =
        await http.get(Uri.parse(_apiUrlRestaurant + "detail/" + id));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromMap(json.decode(response.body));
    } else {
      throw Exception('Gagal Mengambil Load Dari Headlines Detail');
    }
  }
}
