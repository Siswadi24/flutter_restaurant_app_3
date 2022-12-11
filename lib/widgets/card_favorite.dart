import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app_3/model/data/restaurant_detail.dart';

import 'package:restaurant_app_3/style/customStyle.dart';

class CardFavoriteCustom extends StatelessWidget {
  // final String imageRestaurant, nameRestaurant, cityRestaurant;
  // final double ratingRestaurant;
  final Restaurant restaurantData;

  const CardFavoriteCustom({
    super.key,
    required this.restaurantData,
    // required this.imageRestaurant,
    // required this.nameRestaurant,
    // required this.cityRestaurant,
    // required this.ratingRestaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.1,
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  "https://restaurant-api.dicoding.dev/images/medium/${restaurantData.pictureId}",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                restaurantData.name,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 16, fontWeight: FontWeight.bold, color: dark),
              ),
              Text(
                restaurantData.city,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontSize: 15, fontWeight: FontWeight.bold, color: dark),
              ),
              Row(
                children: <Widget>[
                  RatingBar(
                    initialRating: restaurantData.rating.toDouble(),
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 17,
                    ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      half: Icon(
                        Icons.star_half_rounded,
                        color: orange,
                      ),
                      empty: Icon(
                        Icons.star_border_rounded,
                        color: grey1,
                      ),
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    restaurantData.toString(),
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 15, fontWeight: FontWeight.bold, color: dark),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
