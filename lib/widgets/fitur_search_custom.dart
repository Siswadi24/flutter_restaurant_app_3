import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app_3/model/api/api_service.dart';
import 'package:restaurant_app_3/provider/restaurant_search_provider.dart';
import 'package:restaurant_app_3/ui/restaurant_list_page.dart';
import 'package:restaurant_app_3/widgets/search_card.dart';

class CustomSearchFitur extends StatefulWidget {
  static const routeName = '/restauran_list';
  const CustomSearchFitur({Key? key}) : super(key: key);

  @override
  State<CustomSearchFitur> createState() => _CustomSearchFiturState();
}

class _CustomSearchFiturState extends State<CustomSearchFitur> {
  String resultSearch = '';
  TextEditingController controllerTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => RestaurantSearchProvider(apiService: ApiService()),
      child: Consumer<RestaurantSearchProvider>(
        builder: (context, koneksi, _) {
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: <Widget>[
                  Container(
                    // height: 20,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(8.0),
                    padding:
                        const EdgeInsets.only(left: 20, right: 10, top: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(15, 15),
                              blurRadius: 20,
                              color: Colors.grey.shade500.withOpacity(0.30))
                        ]),
                    child: TextField(
                      // autofocus: bool.fromEnvironment(ResultSearch),
                      controller: controllerTextField,
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      decoration: InputDecoration(
                        hintText: 'Search Restaurant Now',
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.23)),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.withOpacity(0.6),
                        ),
                      ),
                      onChanged: (String query) {
                        if (query.length >= 3) {
                          setState(() {
                            resultSearch = query;
                          });
                          koneksi.getSearchRestaurants(resultSearch);
                        }
                      },
                    ),
                  ),
                  (resultSearch.isEmpty)
                      ? Center(
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                          ),
                        )
                      : Consumer<RestaurantSearchProvider>(
                          builder: (context, state, _) {
                            if (state.stateListRestaurantSearch ==
                                ResultStateSearch.loading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state.stateListRestaurantSearch ==
                                ResultStateSearch.hashData) {
                              return Expanded(
                                child: SingleChildScrollView(
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state
                                          .restaurantResultListSearch!
                                          .restaurants
                                          .length,
                                      itemBuilder: (context, index) {
                                        var restaurantResult = state
                                            .restaurantResultListSearch!
                                            .restaurants[index];
                                        return RestaurantCardSearchPageCustom(
                                          restaurantResult: restaurantResult,
                                        );
                                      }),
                                ),
                              );
                            } else if (state.stateListRestaurantSearch ==
                                ResultStateSearch.noData) {
                              return Center(
                                  child:
                                      Text(state.messageListRestaurantSearch));
                            } else if (state.stateListRestaurantSearch ==
                                ResultStateSearch.error) {
                              return Center(
                                  child:
                                      Text(state.messageListRestaurantSearch));
                            } else {
                              return Center(child: Text(''));
                            }
                          },
                        ),
                  // Expanded(child: RestaurantListPage())
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
