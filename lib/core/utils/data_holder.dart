// import 'package:flutter/material.dart';
// import 'package:lab_track/features/points/models/laboratory_exercise.dart';
// import 'package:lab_track/features/points/models/professor.dart';
// import 'package:lab_track/features/points/models/student.dart';
//
// import '../../features/auth/models/user.dart';
// import '../../features/points/models/course.dart';
//
// class DataHolder extends ChangeNotifier {
//   static final List<Course> courses = [
//     Course(
//       id: 1,
//       semester: 3,
//       code: "TEST",
//       name: 'Algorithms and Data Structures',
//       laboratoryExercises: [
//         LaboratoryExercise(
//           id: 1,
//           name: 'Arrays and SLL',
//           dateTime: DateTime(2024, 12, 20, 14, 30),
//           studentPoints: {
//             '222077': 1,
//             '223145': 2,
//           },
//           maxPoints: 3,
//         ),
//         LaboratoryExercise(
//           id: 2,
//           name: 'DLL',
//           dateTime: DateTime(2024, 12, 27, 14, 30),
//           studentPoints: {
//             '222077': 3,
//             '223145': 2,
//             '213064': 1,
//           },
//           maxPoints: 3,
//         ),
//       ],
//       students: [],
//     ),
//     Course(
//       code: "TEST",
//       id: 2,
//       semester: 4,
//       name: 'Operating Systems',
//       laboratoryExercises: [
//         LaboratoryExercise(
//           id: 1,
//           name: 'Processes and Threads',
//           dateTime: DateTime(2024, 12, 21, 15, 0),
//           studentPoints: {
//             '222077': 10,
//             '223145': 9,
//             '213064': 8,
//           },
//           maxPoints: 10,
//         ),
//         LaboratoryExercise(
//           id: 2,
//           name: 'Memory Management',
//           dateTime: DateTime(2024, 12, 28, 15, 0),
//           studentPoints: {
//             '222077': 8,
//             '223145': 9,
//             '213064': 10,
//           },
//           maxPoints: 10,
//         ),
//       ],
//       students: [],
//     ),
//   ];
//
//   static final Student student1 = Student(
//     id: 1,
//     username: '222077',
//     password: 'password123',
//     courses: [courses[0], courses[1]],
//     name: 'Кристијан',
//     surname: 'Стојановски',
//   );
//
//   static final Student student2 = Student(
//     id: 2,
//     username: '223145',
//     password: 'password123',
//     courses: [courses[0]],
//     name: 'Горазд',
//     surname: 'Бишковски',
//   );
//
//   static final Student student3 = Student(
//     id: 3,
//     username: '213064',
//     password: 'password123',
//     courses: [courses[1], courses[0]],
//     name: 'Верче',
//     surname: 'Петрушевска',
//   );
//
//   static final Professor professor1 = Professor(
//     id: 4,
//     username: 'petre',
//     password: 'petre123',
//     assignedCourses: [courses[0], courses[1]],
//   );
//
//   static final Professor professor2 = Professor(
//     id: 5,
//     username: 'elena',
//     password: 'elena123',
//     assignedCourses: [courses[0], courses[1]],
//   );
//
//   static final List<User> users = [
//     student1,
//     student2,
//     student3,
//     professor1,
//     professor2,
//   ];
//
//   static void populateCourseStudents() {
//     courses[0].students?.addAll([student1, student2, student3]);
//     courses[1].students?.addAll([student1, student3]);
//   }
//
//   void updateStudentPoints(
//       {required Course course,
//       required LaboratoryExercise lab,
//       required String studentUsername,
//       required int newPoints}) {
//     lab.studentPoints[studentUsername] = newPoints;
//     notifyListeners();
//   }
// }
//
// void initializeData() {
//   DataHolder.populateCourseStudents();
// }
