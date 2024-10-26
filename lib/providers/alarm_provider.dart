import 'package:flutter/foundation.dart';

class AlarmProvider with ChangeNotifier {
  bool _vibrateWhenAlarmSound = false;

  bool get vibrateWhenAlarmSound => _vibrateWhenAlarmSound;

  void setVibrateWhenAlarmSound(bool value) {
    _vibrateWhenAlarmSound = value;
    notifyListeners();
  }

// Add more alarm-related state and methods here
}