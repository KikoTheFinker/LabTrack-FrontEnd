import '../../auth/models/user.dart';
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

  factory Student.fromJson(Map<String, dynamic> studentData) {
    return Student(
      id: studentData['id'],
      username: studentData['username'],
      password: studentData['password'],
      name: studentData['name'],
      surname: studentData['surname'],
      courses: List<Course>.from(
        studentData['courses'].map((courseData) => Course.fromJson(courseData)),
      ),
    );
  }
}
