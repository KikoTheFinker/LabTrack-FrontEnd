import 'package:lab_track/features/points/models/student.dart';

import 'laboratory_exercise.dart';

class Course {
  final int id;
  final String name;
  final int semester;
  final List<LaboratoryExercise>? laboratoryExercises;
  final List<Student> students;

  Course( {
    required this.id,
    required this.name,
    required this.semester,
    required this.students,
    this.laboratoryExercises,
  });
}
