import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "http://localhost:8000";
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final String token = data["access_token"];

      await _storage.write(key: "token", value: token);
      await _storage.write(key: "role", value: _decodeTokenRole(token));

      return true;
    }
    return false;
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: "token");
  }

  static Future<void> logout() async {
    await _storage.delete(key: "token");
    await _storage.delete(key: "role");
  }

  static Future<bool> isAuthenticated() async {
    String? token = await getToken();
    return token != null;
  }

  static String? _decodeTokenRole(String token) {
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
