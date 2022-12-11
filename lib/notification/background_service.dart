import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurant_app_3/main.dart';
import 'package:restaurant_app_3/model/api/api_service.dart';
import 'package:restaurant_app_3/notification/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundServices {
  static BackgroundServices? _instance;
  static const String _isolateName = "BackgroundServices";
  static SendPort? _uiSendPort;

  BackgroundServices._internal() {
    _instance = this;
  }

  factory BackgroundServices() => _instance ?? BackgroundServices._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    debugPrint("BackgroundServices: callback Terpanggil");
    final NotificationHelper _notificationHelper = NotificationHelper();
    var resultNotification = await ApiService().getListRestaurant();
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, resultNotification);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort!.send(null);
  }
}
