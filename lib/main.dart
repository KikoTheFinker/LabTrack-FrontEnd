import 'package:flutter/material.dart';
import 'package:lab_track/routes/app_routes.dart';
import 'package:lab_track/state/auth_provider.dart';
import 'package:lab_track/state/course_details_provider.dart';
import 'package:lab_track/state/course_provider.dart';
import 'package:lab_track/state/course_students_provider.dart';
import 'package:provider/provider.dart';

import 'core/theme/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => CourseProvider()),
        ChangeNotifierProvider(create: (context) => CourseDetailsProvider()),
        ChangeNotifierProvider(create: (context) => CourseStudentsProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab Track',
      theme: appTheme,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
