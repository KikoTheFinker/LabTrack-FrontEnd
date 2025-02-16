import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lab_track/features/auth/auth.dart';
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _token;
  String? _role;

  String? get token => _token;
  String? get role => _role;

  Future<bool> login(String username, String password) async {
    bool success = await AuthService.login(username, password);

    if (success) {
      _token = await AuthService.getToken();
      _role = _decodeTokenRole(_token!);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout(BuildContext context) async {
    await AuthService.logout();
    _token = null;
    _role = null;
    notifyListeners();
    Navigator.pushReplacementNamed(context, '/');
  }

  Future<bool> isAuthenticated() async {
    _token = await _storage.read(key: "token");
    _role = await _storage.read(key: "role");
    return _token != null;
  }

  bool isStudent() {
    return _role == "student";
  }

  bool isProfessor() {
    return _role == "professor";
  }

  String? _decodeTokenRole(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        throw Exception("Invalid JWT token");
      }

      final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final Map<String, dynamic> decoded = jsonDecode(payload);

      return decoded["role"];
    } catch (e) {
      return null;
    }
  }
}
