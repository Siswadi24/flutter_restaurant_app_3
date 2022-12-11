import 'package:flutter/material.dart';

import 'package:restaurant_app_3/ui/restaurant_list_page.dart';
import 'package:restaurant_app_3/widgets/placeholder_custom.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              PlaceHolderCustom(
                placeHolderText: 'Search Do You Want',
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(child: RestaurantListPage()),
            ],
          ),
        ),
      ),
    );
  }
}
