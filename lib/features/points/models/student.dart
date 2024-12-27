import 'package:lab_track/features/auth/auth.dart';
import 'course.dart';

class Student extends User {
  final Course course;

  Student({
    required this.course,
    required super.id,
    required super.username,
    required super.password,
  }) : super(role: UserRole.student);
}
