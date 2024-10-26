import 'package:flutter/material.dart';

class SleepScheduleProvider with ChangeNotifier {
  // Selected bedtime and alarm times
  String bedtime = '09:00pm';
  String alarmTime = '05:10am';

  // Time until bed/alarm (dynamically updated)
  Duration timeUntilBed = Duration(hours: 6, minutes: 22);
  Duration timeUntilAlarm = Duration(hours: 14, minutes: 30);

  // Selected date (for the date picker)
  DateTime selectedDate = DateTime.now();

  // List of dates to display (a week view)
  List<DateTime> weekDates = List.generate(7, (index) {
    return DateTime.now().subtract(Duration(days: DateTime.now().weekday - index));
  });

  // Update bedtime or alarm time
  void updateBedtime(String newTime) {
    bedtime = newTime;
    notifyListeners();
  }

  void updateAlarmTime(String newTime) {
    alarmTime = newTime;
    notifyListeners();
  }

  // Update selected date for the date picker
  void updateSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    notifyListeners();
  }

  // Method to update time until bedtime or alarm
  void updateTimeUntilEvents(Duration untilBed, Duration untilAlarm) {
    timeUntilBed = untilBed;
    timeUntilAlarm = untilAlarm;
    notifyListeners();
  }
}
