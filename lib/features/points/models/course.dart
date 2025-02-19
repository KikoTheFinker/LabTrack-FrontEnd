import 'package:lab_track/features/points/models/student.dart';
import 'laboratory_exercise.dart';

class Course {
  final int id;
  final String name;
  final String code;
  final int semester;
  final List<LaboratoryExercise>? laboratoryExercises;
  final List<Student>? students;

  Course({
    required this.id,
    required this.name,
    required this.code,
    required this.semester,
    this.students,
    this.laboratoryExercises,
  });

  static Course fromJson(Map<String, dynamic> courseData) {
    return Course(
      id: courseData['id'],
      name: courseData['name'],
      code: courseData['code'],
      semester: courseData['semester'],
      students: courseData['students'] != null
          ? List<Student>.from(
        courseData['students'].map((studentData) => Student.fromJson(studentData)),
      )
          : null,
      laboratoryExercises: courseData['laboratory_exercises'] != null
          ? List<LaboratoryExercise>.from(
        courseData['laboratory_exercises'].map(
              (exerciseData) => LaboratoryExercise.fromJson(exerciseData),
        ),
      )
          : null,
    );
  }
}
