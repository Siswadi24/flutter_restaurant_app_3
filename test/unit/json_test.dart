import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app_3/model/data/restaurant_detail.dart';

var RestaurantTestingJson = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.2
};

void main() {
  test('Test Parsing Json Resttaurant List', () async {
    var restaurant = Restaurant.fromMap(RestaurantTestingJson).id;

    expect(restaurant, "rqdv5juczeskfw1e867");
  });
}
