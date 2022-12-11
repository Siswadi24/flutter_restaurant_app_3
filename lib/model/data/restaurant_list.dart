import 'dart:convert';

class RestaurantResult {
  RestaurantResult({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurantss,
  });

  final bool error;
  final String message;
  final int count;
  final List<Restaurant1> restaurantss;

  factory RestaurantResult.fromJson(String str) =>
      RestaurantResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RestaurantResult.fromMap(Map<String, dynamic> json) =>
      RestaurantResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurantss: List<Restaurant1>.from(
            json["restaurants"].map((x) => Restaurant1.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurantss.map((x) => x.toMap())),
      };
}

class Restaurant1 {
  Restaurant1({
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

  factory Restaurant1.fromJson(String str) =>
      Restaurant1.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Restaurant1.fromMap(Map<String, dynamic> json) => Restaurant1(
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
