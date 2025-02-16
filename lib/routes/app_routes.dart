import 'package:flutter/material.dart';

import '../features/auth/presentation/login_screen.dart';
import '../features/points/presentation/professor/professor_home_screen.dart';
import '../features/points/presentation/student/student_home_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String studentHome = '/student_home';
  static const String professorHome = '/professor_home';

  static final routes = <String, WidgetBuilder>{
    login: (context) => LoginScreen(),
    studentHome: (context) => const StudentHomeScreen(),
    professorHome: (context) => const ProfessorHomeScreen(),
  };
}
