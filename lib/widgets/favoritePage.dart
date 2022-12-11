import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:restaurant_app_3/model/data/restaurant_detail.dart';
import 'package:restaurant_app_3/model/data/restaurant_list.dart';
import 'package:restaurant_app_3/provider/database_provider.dart';
import 'package:restaurant_app_3/provider/restaurant_database_provider.dart';
import 'package:restaurant_app_3/style/customStyle.dart';
import 'package:restaurant_app_3/widgets/buttom_tombol_favorite.dart';
import 'package:restaurant_app_3/widgets/card_favorite.dart';
import 'package:restaurant_app_3/widgets/card_favorites.dart';
import 'package:restaurant_app_3/widgets/restaurant_detail_pages_custom.dart';

class FavoritePage extends StatelessWidget {
  final Restaurant1 restaurantData;
  const FavoritePage({super.key, required this.restaurantData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Page',
          style: TextStyle(color: dark),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Consumer<RestaurantDatabaseProvider>(
          builder: (context, RestaurantDatabaseProvider databaseProvider, _) {
            switch (databaseProvider.stateDatabase) {
              case ResultStateDatabase.loading:
                return Center(child: CircularProgressIndicator());
              case ResultStateDatabase.noData:
                return Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Maaf data tidak ditemukan',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Pattaya',
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomTombolFavorite(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => FavoritePage(),
                          //   ),
                          // );
                        },
                        labelFavorite: 'Refresh',
                      ),
                    ),
                    Spacer(),
                  ],
                );
              case ResultStateDatabase.hasData:
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final Restaurant1 restaurantData =
                        databaseProvider.restaurantFavorite[index];
                    return Slidable(
                      key: ValueKey(0),
                      startActionPane:
                          ActionPane(motion: DrawerMotion(), children: [
                        SlidableAction(
                          onPressed: (value) {
                            databaseProvider.removeFavorite(restaurantData.id);
                          },
                          icon: Icons.delete_outline_rounded,
                          backgroundColor: Colors.red,
                          label: 'Delete',
                        ),
                      ]),
                      child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => DetailScreenPage(
                            //         restaurantDetailResult: restaurantData),
                            //   ),
                            // );
                          },
                          child: CardFavoriteCustoms(
                            restaurantResult: restaurantData,
                          )),
                    );
                  },
                  separatorBuilder: (context, _) {
                    return SizedBox(
                      height: 10.0,
                    );
                  },
                  itemCount: databaseProvider.restaurantFavorite.length,
                );
              case ResultStateDatabase.error:
                return Center(
                    child:
                        Text('Maaf Terjadi Kesalahan Mohon Coba Lagi Nanti'));
              default:
                return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
