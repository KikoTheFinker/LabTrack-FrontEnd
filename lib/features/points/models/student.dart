import 'package:lab_track/features/auth/auth.dart';
import 'course.dart';

class Student extends User {
  final List<Course> courses;
  final String name;
  final String surname;

  Student({
    required this.name,
    required this.surname,
    required this.courses,
    required super.id,
    required super.username,
    required super.password,
  }) : super(role: UserRole.student);
}
