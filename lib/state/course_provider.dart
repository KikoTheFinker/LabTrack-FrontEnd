import 'package:flutter/material.dart';
import 'package:lab_track/core/services/api.dart';
import 'package:provider/provider.dart';

import '../features/points/models/course.dart';
import 'auth_provider.dart';

class CourseProvider extends ChangeNotifier {
  List<Course> _courses = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Course> get courses => _courses;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchCourses(BuildContext context) async {
    final token = Provider.of<AuthProvider>(context, listen: false).token;

    if (token == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/');
        }
      });
      return;
    }

    try {
      _isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });

      final response = await ApiService.get("/my-courses", token);

      if (response != null && response.containsKey("courses")) {
        var coursesData = response["courses"] as List<dynamic>?;

        if (coursesData != null) {
          _courses = List<Course>.from(
            coursesData
                .map((courseData) => Course.fromJson(courseData['course'])),
          );
        }
      } else {
        _errorMessage = 'Failed to load courses';
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch courses.';
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _isLoading = false;
        notifyListeners();
      });
    }
  }
}
