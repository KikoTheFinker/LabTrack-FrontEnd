import 'package:flutter/material.dart';
import '../features/auth/auth.dart';
import '../features/points/presentation/student/student_home_screen.dart';
import '../features/points/presentation/search_screen.dart';

class AppRoutes{
  static const String login = '/';
  static const String studentHome = '/student_home';
  static const String professorSearch = '/professor_home';

  static final routes = <String, WidgetBuilder>{
    login: (context) => LoginScreen(),
    studentHome: (context) =>  const StudentHomePage(),
    professorSearch: (context) => const SearchScreen(),
  };
}