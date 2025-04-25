import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  // Example properties
  String _token = '';
  bool _isAuthenticated = false;

  // Getters
  String get token => _token;
  bool get isAuthenticated => _isAuthenticated;

  // Methods to update authentication state
  void login(String token) {
    _token = token;
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _token = '';
    _isAuthenticated = false;
    notifyListeners();
  }
}