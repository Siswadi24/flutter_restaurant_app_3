import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_3/notification/background_service.dart';
import 'package:restaurant_app_3/notification/notification_helper.dart';
import 'package:restaurant_app_3/provider/scheduling_restaurant_provider.dart';
import 'package:restaurant_app_3/style/common/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/navigator_provider.dart';

import 'package:restaurant_app_3/model/database/database_helper.dart';
import 'package:restaurant_app_3/provider/restaurant_database_provider.dart';
import 'package:restaurant_app_3/ui/splashScreen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundServices backgroundServices = BackgroundServices();
  backgroundServices.initializeIsolate();
  await AndroidAlarmManager.initialize();
  await notificationHelper.initialNotification(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChooseNavigation()),
        ChangeNotifierProvider(
            create: (_) => RestaurantDatabaseProvider(
                databaseHelperRestaurant: DatabaseHelper())),
        ChangeNotifierProvider(
            create: (_) => SchedulingRestaurantProvider(
                    preferencesRestaurantHelper: PreferencesRestaurantHelper(
                  sharedPreferences: SharedPreferences.getInstance(),
                )))
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreenPage(),
      ),
    );
  }
}

// MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const SplashScreenPage(),
//     );
