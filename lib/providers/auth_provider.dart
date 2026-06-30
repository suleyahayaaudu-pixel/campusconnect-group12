import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _userEmail;

  String? get userEmail => _userEmail;
  bool get isLoggedIn => _userEmail != null;

  Future<String?> register(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Email and password are required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    _userEmail = email;
    notifyListeners();
    return null;
  }

  Future<String?> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Email and password are required';
    }
    _userEmail = email;
    notifyListeners();
    return null;
  }

  Future<void> logout() async {
    _userEmail = null;
    notifyListeners();
  }
}
