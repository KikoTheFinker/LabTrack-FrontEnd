import 'package:lab_track/features/points/models/laboratory_exercise.dart';

class Course {
  final int id;
  final int semester;
  final String name;
  final List<LaboratoryExercise>? laboratoryExercises;

  Course(
      {required this.id,
      required this.semester,
      required this.name,
        this.laboratoryExercises});
}
