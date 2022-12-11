import 'dart:convert';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'package:restaurant_app_3/model/data/restaurant_list.dart';
import 'package:restaurant_app_3/style/common/navigation.dart';

final NotificationHelperSelectSubjek = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initialNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      if (payload != null) {
        print('Notification Payload: $payload');
      }
      NotificationHelperSelectSubjek.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResult restaurantResult) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "Restaurant App Channel";
    var random = restaurantResult.restaurantss[
        Random().nextInt(restaurantResult.restaurantss.length - 1)];

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotificationRestaurant = random.name;
    var titleDeskripsiRestaurant = random.description;

    await flutterLocalNotificationsPlugin.show(0, titleNotificationRestaurant,
        titleDeskripsiRestaurant, platformChannelSpecifics,
        payload: json.encode(restaurantResult.toMap()));
  }

  void configurasiSelectNotificationSubjectRestaurant(String route) {
    NotificationHelperSelectSubjek.stream.listen((String payload) async {
      var dataRestaurant = RestaurantResult.fromMap(json.decode(payload));
      var restaurant = dataRestaurant.restaurantss[0];

      NavigationHelper.intentWithData(route, restaurant);
    });
  }
}
