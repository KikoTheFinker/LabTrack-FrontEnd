import 'package:lab_track/features/points/models/laboratory_exercise.dart';

class Course {
  final int id;
  final String name;
  final List<LaboratoryExercise> laboratoryExercises;
  final int semester;

  Course(
      {required this.id,
      required this.semester,
      required this.name,
      required this.laboratoryExercises});
}
