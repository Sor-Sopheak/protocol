import 'package:flutter/material.dart';
import 'package:protocol_app/models/responses/auth_response_model.dart';
import 'package:protocol_app/models/responses/error_response_model.dart';
import 'package:protocol_app/services/auth_service.dart';
import 'package:protocol_app/utilities/auth_helper.dart';

class AuthProvider with ChangeNotifier {
  final AuthService authService;
  AuthProvider({required this.authService});

  bool _isLoading = false;
  String _token = '';
  bool _isAuthenticated = false;

  // Getters
  bool get isLoading => _isLoading;
  String get token => _token;
  bool get isAuthenticated => _isAuthenticated;

  // Methods to update authentication state
  Future<dynamic> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await authService.login(email, password);
    if (result is AuthResponseModel) {
      _isAuthenticated = true;
      _token = result.accessToken; // Store the access token
      AuthHelper.saveToLocalStorage('access_token', _token);
      AuthHelper.saveToSessionStorage('access_token', _token);
      print('Access Token: $_token');
      _isLoading = false;
      notifyListeners();
      return result;
    } else if (result is ErrorResponseModel) {
      _isLoading = false;
      notifyListeners();
      return result;
    } else {
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _token = ''; // Clear the token
    // Optionally, clear any persisted token
    notifyListeners();
    // Optionally, you might want to call a logout endpoint in your AuthService
  }
}
