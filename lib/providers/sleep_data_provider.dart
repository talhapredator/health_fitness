import 'package:flutter/material.dart';

class SleepData with ChangeNotifier {
  double lastNightSleep = 8.2;
  double increasePercentage = 43;
  String bedtime = '09:00pm';
  String alarmTime = '05:10am';
  Duration timeUntilBed = Duration(hours: 6, minutes: 22);
  Duration timeUntilAlarm = Duration(hours: 14, minutes: 30);

  // New: Weekly sleep data (hours slept each day)
  List<double> weeklySleepData = [6.5, 7.0, 5.5, 8.0, 7.5, 6.8, 8.5]; // Example data for Sun-Sat

  // Update the weekly sleep data
  void updateWeeklySleepData(List<double> newWeeklyData) {
    weeklySleepData = newWeeklyData;
    notifyListeners();
  }

  // Update last night's sleep
  void updateLastNightSleep(double hours) {
    lastNightSleep = hours;
    notifyListeners();
  }

  // Additional methods to update other fields if needed
  void updateBedtime(String newBedtime) {
    bedtime = newBedtime;
    notifyListeners();
  }

  void updateAlarmTime(String newAlarmTime) {
    alarmTime = newAlarmTime;
    notifyListeners();
  }

  // Update the time until bed and alarm dynamically
  void updateTimeUntilBed(Duration newTime) {
    timeUntilBed = newTime;
    notifyListeners();
  }

  void updateTimeUntilAlarm(Duration newTime) {
    timeUntilAlarm = newTime;
    notifyListeners();
  }
}
