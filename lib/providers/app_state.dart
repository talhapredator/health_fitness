import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _isUserLoggedIn = false;

  bool get isUserLoggedIn => _isUserLoggedIn;

  void logIn() {
    _isUserLoggedIn = true;
    notifyListeners();  // Notify listeners of state change
  }

  void logOut() {
    _isUserLoggedIn = false;
    notifyListeners();  // Notify listeners of state change
  }
}
