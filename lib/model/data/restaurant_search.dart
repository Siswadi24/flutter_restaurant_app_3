import 'dart:convert';

// class RestaurantResulSearch {
//   RestaurantResulSearch({
//     required this.error,
//     required this.founded,
//     required this.restaurantsSearch,
//   });

//   final bool error;
//   int founded;
//   final List<RestaurantResultSearch> restaurantsSearch;

//   factory RestaurantResulSearch.fromJson(String str) =>
//       RestaurantResulSearch.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory RestaurantResulSearch.fromMap(Map<String, dynamic> json) =>
//       RestaurantResulSearch(
//         error: json["error"],
//         founded: json["founded"],
//         restaurantsSearch: List<RestaurantResultSearch>.from(
//             json["restaurantsSearch"]
//                 .map((x) => RestaurantResultSearch.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "error": error,
//         "founded": founded,
//         "restaurantsSearch":
//             List<dynamic>.from(restaurantsSearch.map((x) => x.toMap())),
//       };
// }

// class RestaurantResultSearch {
//   RestaurantResultSearch({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.pictureId,
//     required this.city,
//     required this.rating,
//   });

//   final String id;
//   final String name;
//   final String description;
//   final String pictureId;
//   final String city;
//   final double rating;

//   factory RestaurantResultSearch.fromJson(String str) =>
//       RestaurantResultSearch.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory RestaurantResultSearch.fromMap(Map<String, dynamic> json) =>
//       RestaurantResultSearch(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         pictureId: json["pictureId"],
//         city: json["city"],
//         rating: json["rating"].toDouble(),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "description": description,
//         "pictureId": pictureId,
//         "city": city,
//         "rating": rating,
//       };
// }

// To parse this JSON data, do
//
//     final restaurantSearch = restaurantSearchFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class RestaurantResulSearch {
  RestaurantResulSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  final bool error;
  final int founded;
  final List<RestaurantResultSearch> restaurants;

  factory RestaurantResulSearch.fromJson(String str) =>
      RestaurantResulSearch.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RestaurantResulSearch.fromMap(Map<String, dynamic> json) =>
      RestaurantResulSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantResultSearch>.from(
            json["restaurants"].map((x) => RestaurantResultSearch.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toMap())),
      };
}

class RestaurantResultSearch {
  RestaurantResultSearch({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  factory RestaurantResultSearch.fromJson(String str) =>
      RestaurantResultSearch.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RestaurantResultSearch.fromMap(Map<String, dynamic> json) =>
      RestaurantResultSearch(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
