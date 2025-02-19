import 'package:flutter/material.dart';
import 'package:lab_track/core/services/api.dart';
import 'package:provider/provider.dart';

import '../features/points/models/laboratory_exercise.dart';
import 'auth_provider.dart';

class CourseDetailsProvider extends ChangeNotifier {
  List<LaboratoryExercise>? _laboratoryExercises = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<LaboratoryExercise>? get laboratoryExercises => _laboratoryExercises;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchStudentLaboratoryExercises(
      BuildContext context, int courseId) async {
    final token = Provider.of<AuthProvider>(context, listen: false).token;

    if (token == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/');
      });
      return;
    }

    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final response = await ApiService.get("/student/$courseId", token);

      if (response != null && response.containsKey('assignments')) {
        _laboratoryExercises = (response['assignments'] as List)
            .map((data) => LaboratoryExercise.fromJson(data))
            .toList();
      } else {
        _errorMessage = 'Failed to load course assignments';
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch course assignments: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
