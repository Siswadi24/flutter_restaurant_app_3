import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:restaurant_app_3/model/api/api_service.dart';
import 'package:restaurant_app_3/provider/restaurant_list_provider.dart';
import 'package:restaurant_app_3/widgets/restaurant_list_custom.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = 'restaurant_list';
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => RestaurantListProvider(apiService: ApiService()),
        child: Consumer<RestaurantListProvider>(
          builder: (context, state, _) {
            if (state.stateListRestaurant == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.stateListRestaurant == ResultState.hashData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.restaurantResultList.restaurantss.length,
                  itemBuilder: ((context, index) {
                    var restaurantListPage =
                        state.restaurantResultList.restaurantss[index];
                    return RestaurantListPageCustom(
                        restaurantResult: restaurantListPage);
                  }));
            } else if (state.stateListRestaurant == ResultState.noData) {
              return Center(child: Text(state.messageListRestaurant));
            } else if (state.stateListRestaurant == ResultState.error) {
              return Center(child: Text(state.messageListRestaurant));
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
