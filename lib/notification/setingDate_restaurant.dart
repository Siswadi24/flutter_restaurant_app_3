import 'package:intl/intl.dart';

class DateTimeRestaurantHelper {
  static DateTime formatDateTime() {
    final now = DateTime.now();
    final dateTimeFormat = DateFormat('yyyy-MM-dd');
    final timeSpesificRestaurant = '21:40:00';
    final dateFormatCompleteRestaurant = DateFormat('yyyy-MM-dd HH:mm:ss');

    final todayDate = dateTimeFormat.format(now);
    final todayDateComplete = '$todayDate $timeSpesificRestaurant';
    var todayDateCompleteRestaurant =
        dateFormatCompleteRestaurant.parseStrict(todayDateComplete);

    var formatedDateRestaurant =
        todayDateCompleteRestaurant.add(Duration(days: 1));
    final tomorrowDateRestaurant =
        dateTimeFormat.format(formatedDateRestaurant);
    final ttomorrowAndTimeRestaurant =
        '$tomorrowDateRestaurant $timeSpesificRestaurant';
    var tomorrowDateCompleteRestaurant =
        dateFormatCompleteRestaurant.parseStrict(ttomorrowAndTimeRestaurant);

    return now.isAfter(todayDateCompleteRestaurant)
        ? tomorrowDateCompleteRestaurant
        : todayDateCompleteRestaurant;
  }
}
