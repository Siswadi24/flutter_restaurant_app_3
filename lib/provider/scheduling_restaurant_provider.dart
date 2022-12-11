import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app_3/notification/background_service.dart';
import 'package:restaurant_app_3/notification/setingDate_restaurant.dart';
import 'package:restaurant_app_3/style/common/preferences_helper.dart';

class SchedulingRestaurantProvider extends ChangeNotifier {
  PreferencesRestaurantHelper preferencesRestaurantHelper;
  SchedulingRestaurantProvider({required this.preferencesRestaurantHelper}) {
    _getReminderRestaurant();
  }

  bool _isReminderRestaurant = true;
  bool get isReminderRestaurant => _isReminderRestaurant;

  void _getReminderRestaurant() async {
    _isReminderRestaurant =
        await preferencesRestaurantHelper.isReminderRestaurant;
    notifyListeners();
  }

  void enableReminderRestaurant(bool value) {
    preferencesRestaurantHelper.setReminderRestaurant(value);
    schedulingRestaurant(value);
    notifyListeners();
  }

  Future<bool> schedulingRestaurant(bool value) async {
    _isReminderRestaurant = value;
    if (_isReminderRestaurant) {
      print('SchedulingRestaurantProvider: SchedulingRestaurant Aktif');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundServices.callback,
        startAt: DateTimeRestaurantHelper.formatDateTime(),
        wakeup: true,
        exact: true,
        rescheduleOnReboot: true,
      );
    } else {
      print('SchedulingRestaurantProvider: SchedulingRestaurant Tidak Aktif');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
