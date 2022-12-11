import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_3/provider/database_provider.dart';
import 'package:restaurant_app_3/provider/restaurant_database_provider.dart';
import 'package:restaurant_app_3/widgets/card_favorite.dart';
import 'package:restaurant_app_3/widgets/card_favorites.dart';
import 'package:restaurant_app_3/widgets/favoritePage.dart';

class RestaurantFavoritePage extends StatelessWidget {
  const RestaurantFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDatabaseProvider>(
      builder: (context, state, _) {
        if (state.stateDatabase == ResultStateDatabase.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.stateDatabase == ResultStateDatabase.noData) {
          return Center(child: Text('Mohon maaf data tidak ditemukan'));
        } else if (state.stateDatabase == ResultStateDatabase.error) {
          return Center(child: Text(state.message));
        } else if (state.stateDatabase == ResultStateDatabase.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.restaurantFavorite.length,
            itemBuilder: (context, index) {
              var restaurantData = state.restaurantFavorite[index];
              return CardFavoriteCustoms(restaurantResult: restaurantData);
            },
          );
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }
}
