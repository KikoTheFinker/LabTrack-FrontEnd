import 'package:lab_track/features/points/models/course.dart';

import '../../auth/models/user.dart';

class Professor extends User {
  final List<Course> assignedCourses;

  Professor({
    required super.id,
    required super.username,
    required super.password,
    required this.assignedCourses,
  }) : super(role: UserRole.professor);
}
