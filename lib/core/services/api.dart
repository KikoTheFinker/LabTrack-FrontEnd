import 'package:dio/dio.dart';

class ApiService {
  static final Dio _dio = Dio(BaseOptions(
      baseUrl: "http://localhost:8000",
      connectTimeout: const Duration(seconds: 200),
      receiveTimeout: const Duration(seconds: 200)));

  static Future<Map<String, dynamic>?> get(
      String endpoint, String? token) async {
    try {
      final response = await _dio.get(
        endpoint,
        options: Options(
          headers: token != null ? {"Authorization": "Bearer $token"} : {},
        ),
      );

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        print('Unexpected response type: ${response.data.runtimeType}');
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> post(
    String endpoint, {
    required String body,
    String? token,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: body,
        options: Options(headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        }),
      );
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
