import 'package:flutter/material.dart';
import 'package:lab_track/core/utils/data_holder.dart';
import 'package:lab_track/features/auth/auth.dart';
import 'package:lab_track/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'core/theme/theme.dart';

void main() {
  initializeData();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DataHolder()),
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
