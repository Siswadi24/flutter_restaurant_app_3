import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRestaurantHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesRestaurantHelper({required this.sharedPreferences});
  static const ReminderRestaurant = 'ReminderRestaurant';

  Future<bool> get isReminderRestaurant async {
    final prefs = await sharedPreferences;
    return prefs.getBool(ReminderRestaurant) ?? false;
  }

  void setReminderRestaurant(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(ReminderRestaurant, value);
  }
}
