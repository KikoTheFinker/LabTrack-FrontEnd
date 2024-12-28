import 'package:flutter/material.dart';
import 'package:lab_track/features/auth/auth.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  bool login(String username, String password) {
    final user = AuthService.authenticateUser(username, password);

    if (user != null) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout(){
    _currentUser = null;
    notifyListeners();
  }
}
