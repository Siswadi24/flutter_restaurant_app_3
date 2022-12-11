import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_3/provider/scheduling_restaurant_provider.dart';

class RestaurantSettingPages extends StatefulWidget {
  const RestaurantSettingPages({super.key});

  @override
  State<RestaurantSettingPages> createState() => _RestaurantSettingPagesState();
}

class _RestaurantSettingPagesState extends State<RestaurantSettingPages> {
  String clickPreferences = 'Klik ini untuk mengatur preferensi';

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('Scheduling'),
        trailing: Consumer<SchedulingRestaurantProvider>(
            builder: (context, sheduled, _) {
          return Switch.adaptive(
            value: sheduled.isReminderRestaurant,
            onChanged: (value) async {
              sheduled.enableReminderRestaurant(value);
              sheduled.schedulingRestaurant(value);
            },
          );
        }));
  }
}
