import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  String? get token => _token;

  // Method to log in the user
  Future<void> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/users/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final jwtToken = data['token'];

        // Store the JWT token in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwtToken', jwtToken);

        // Update the provider state
        _token = jwtToken;
        _isLoggedIn = true;
        notifyListeners();
        print("Login successful, token saved");
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      print("Error logging in: $e");
    }
  }

  // Method to log out the user
  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');  // Clear the token from storage
    _token = null;
    _isLoggedIn = false;
    notifyListeners();
    print("Logged out, token cleared");
  }

  // Method to check if the user is logged in on app startup
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('jwtToken');
    if (storedToken != null) {
      _token = storedToken;
      _isLoggedIn = true;
      notifyListeners();
    }
  }
}
