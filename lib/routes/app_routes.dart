import 'package:flutter/material.dart';
import '../features/auth/auth.dart';
import '../features/points/presentation/student_home_screen.dart';
import '../features/points/presentation/search_screen.dart';

class AppRoutes{
  static const String login = '/';
  static const String studentHome = '/studentHome';
  static const String professorSearch = '/professorSearch';

  static final routes = <String, WidgetBuilder>{
    login: (context) => LoginScreen(),
    studentHome: (context) => const StudentHomeScreen(),
    professorSearch: (context) => const SearchScreen(),
  };
}