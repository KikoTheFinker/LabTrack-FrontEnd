import 'package:lab_track/features/auth/auth.dart';

class Professor extends User {
  final List<String> assignedCourses;

  Professor({
    required super.id,
    required super.username,
    required super.password,
    required this.assignedCourses,
  }) : super(role: UserRole.professor);
}
