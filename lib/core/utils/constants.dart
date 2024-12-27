import 'package:lab_track/features/points/models/laboratory_exercise.dart';
import '../../features/auth/auth.dart';
import '../../features/points/models/course.dart';

final List<User> users = [
  User(
    id: 1,
    username: '222077',
    password: 'password123',
    role: UserRole.student,
  ),
  User(
    id: 2,
    username: '223145',
    password: 'password123',
    role: UserRole.student,
  ),
  User(
    id: 3,
    username: '213064',
    password: 'password123',
    role: UserRole.student,
  ),
  User(
    id: 4,
    username: 'petre',
    password: 'petre123',
    role: UserRole.professor,
  ),
  User(
    id: 5,
    username: 'elena',
    password: 'elena123',
    role: UserRole.assistant,
  ),
];
final List<Course> courses = [
  Course(
    id: 1,
    name: 'Algorithms and Data Structures',
    laboratoryExercises: [
      LaboratoryExercise(
        id: 1,
        name: 'Arrays and SLL',
        dateTime: DateTime(2024, 12, 20, 14, 30),
        studentPoints: {
          '222077': 1,
          '223145': 2,
          '213064': 3,
        },
        maxPoints: 3,
      ),
      LaboratoryExercise(
        id: 2,
        name: 'DLL',
        dateTime: DateTime(2024, 12, 27, 14, 30),
        studentPoints: {
          '222077': 3,
          '223145': 2,
          '213064': 1,
        },
        maxPoints: 3,
      ),
    ],
  ),
  Course(
    id: 2,
    name: 'Operating Systems',
    laboratoryExercises: [
      LaboratoryExercise(
        id: 3,
        name: 'Processes and Threads',
        dateTime: DateTime(2024, 12, 21, 15, 0),
        studentPoints: {
          '222077': 10,
          '223145': 9,
          '213064': 8,
        },
        maxPoints: 10,
      ),
      LaboratoryExercise(
        id: 4,
        name: 'Memory Management',
        dateTime: DateTime(2024, 12, 28, 15, 0),
        studentPoints: {
          '222077': 8,
          '223145': 9,
          '213064': 10,
        },
        maxPoints: 10,
      ),
    ],
  ),
];
