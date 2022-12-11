import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_3/model/data/restaurant_list.dart';
import 'package:restaurant_app_3/ui/restaurant_detail_pages.dart';

class CardFavoriteCustoms extends StatelessWidget {
  final Restaurant1 restaurantResult;
  const CardFavoriteCustoms({super.key, required this.restaurantResult});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return RestaurantDetailPages(idRestaurant: restaurantResult.id);
            },
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Hero(
                  tag: restaurantResult.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://restaurant-api.dicoding.dev/images/small/${restaurantResult.pictureId}",
                      width: 150,
                      height: 120,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(),
                        widthFactor: 0.8,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          restaurantResult.name,
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.visible,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              size: 18,
                            ),
                            Text(restaurantResult.rating.toString()),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text(restaurantResult.city),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 1,
            indent: 15,
            endIndent: 15,
          )
        ],
      ),
    );
  }
}
