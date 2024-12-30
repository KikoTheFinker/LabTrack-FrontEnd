import 'package:lab_track/features/auth/auth.dart';
import 'course.dart';

class Student extends User {
  final List<Course> courses;

  Student({
    required this.courses,
    required super.id,
    required super.username,
    required super.password,
  }) : super(role: UserRole.student);
}
