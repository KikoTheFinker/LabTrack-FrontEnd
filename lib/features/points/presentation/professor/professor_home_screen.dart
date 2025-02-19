import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lab_track/core/utils/data_holder.dart';
import 'package:lab_track/core/widgets/logout_button.dart';
import 'package:lab_track/features/points/presentation/professor/professor_course_details_screen.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/course_filter.dart';
import '../../../../core/widgets/course_list_view.dart';
import '../../../../core/widgets/search_and_filter.dart';
import '../../../../state/auth_provider.dart';
import '../../models/course.dart';
import '../../models/professor.dart';

class ProfessorHomeScreen extends StatefulWidget {
  const ProfessorHomeScreen({super.key});

  @override
  State<ProfessorHomeScreen> createState() => _ProfessorHomeScreenState();
}

class _ProfessorHomeScreenState extends State<ProfessorHomeScreen> {
  String _searchQuery = '';
  int? _selectedSemester;
  String _token = "";

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  Future<void> _getToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    String? token = await storage.read(key: "token");
    setState(() {
      _token = token ?? "No token found";
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AuthProvider>(context).token;
    if (currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/');
      });
      return const Scaffold();
    }
    final Professor professor1 = Professor(
     id: 4,
     username: 'test',
     password: 'test', assignedCourses: [],
  );
    final professorCourses = professor1.assignedCourses;

    final filteredCourses = filterCourses(
      courses: professorCourses,
      searchQuery: _searchQuery,
      selectedSemester: _selectedSemester,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Professor Dashboard',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 1,
        actions: const [
          LogoutButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Token: $_token',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 24),
            SearchAndFilterBar(
              searchQuery: _searchQuery,
              onSearchChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              selectedSemester: _selectedSemester,
              semesters: [
                ...{...professorCourses.map((course) => course.semester)}
              ],
              onSemesterChanged: (value) {
                setState(() {
                  _selectedSemester = value;
                });
              },
            ),
            const SizedBox(height: 24),
            Expanded(
              child: filteredCourses.isEmpty
                  ? const Center(
                child: Text(
                  'No courses found.',
                  style: TextStyle(
                      fontSize: 16, color: AppColors.primaryColor),
                ),
              )
                  : CourseListView(
                courses: filteredCourses,
                onCourseTap: (course) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfessorCourseDetailsScreen(
                        course: course,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
