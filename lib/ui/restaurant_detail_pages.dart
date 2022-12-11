import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app_3/model/api/api_service.dart';
import 'package:restaurant_app_3/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app_3/widgets/restaurant_detail_pages_custom.dart';

class RestaurantDetailPages extends StatelessWidget {
  static const routeName = '/detail_restaurant_page';
  final String idRestaurant;
  const RestaurantDetailPages({Key? key, required this.idRestaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) => RestaurantDetailProvider(
            apiService: ApiService(), id: idRestaurant),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.stateDetailRestaurant == ResultStateDetail.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.stateDetailRestaurant ==
                ResultStateDetail.hashData) {
              final restaurantDetail = state.restaurantResultDetail!.restaurant;
              return DetailScreenPage(restaurantDetailResult: restaurantDetail);
            } else if (state.stateDetailRestaurant ==
                ResultStateDetail.noData) {
              return Center(child: Text(state.messageDetailRestaurant));
            } else if (state.stateDetailRestaurant == ResultStateDetail.error) {
              return Center(child: Text(state.messageDetailRestaurant));
            } else {
              return Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
