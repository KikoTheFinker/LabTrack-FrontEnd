import 'package:flutter/material.dart';
import 'package:lab_track/features/points/models/student.dart';

import '../core/services/api.dart';

class CourseStudentsProvider with ChangeNotifier {
  List<Student> _students = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Student> get students => _students;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchStudentsForCourse(int courseId, String token) async {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      final response = await ApiService.get(
          "/courses/$courseId/students", token);

      if (response != null && response.containsKey("students")) {
        final List<dynamic> studentData = response["students"];
        _students =
            studentData.map((student) => Student.fromJson(student)).toList();
      } else {
        _errorMessage = "No students found.";
      }
    } catch (e) {
      _errorMessage = "Failed to fetch students: ${e.toString()}";
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _isLoading = false;
        notifyListeners();
      });
    }
  }
}
