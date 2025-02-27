import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lab_track/core/widgets/logout_button.dart';
import 'package:lab_track/features/points/presentation/professor/professor_course_details_screen.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/course_list_view.dart';
import '../../../../core/widgets/search_and_filter.dart';
import '../../../../state/course_provider.dart';

class ProfessorHomeScreen extends StatefulWidget {
  const ProfessorHomeScreen({super.key});

  @override
  State<ProfessorHomeScreen> createState() => _ProfessorHomeScreenState();
}

class _ProfessorHomeScreenState extends State<ProfessorHomeScreen> {
  String _searchQuery = '';
  int? _selectedSemester;
  bool _isTokenValid = false;

  @override
  void initState() {
    super.initState();
    _checkTokenAndFetchCourses();
  }

  Future<void> _checkTokenAndFetchCourses() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    String? token = await storage.read(key: "token");

    if (token == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
    } else {
      setState(() {
        _isTokenValid = true;
      });
      Provider.of<CourseProvider>(context, listen: false).fetchUserCourses(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isTokenValid) {
      return const Scaffold();
    }

    final courseProvider = Provider.of<CourseProvider>(context);
    final allCourses = courseProvider.courses;

    final filteredCourses = allCourses.where((course) {
      final matchesSearch = course.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          course.code.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesSemester = _selectedSemester == null || course.semester == _selectedSemester;

      return matchesSearch && matchesSemester;
    }).toList();

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
            SearchAndFilterBar(
              searchQuery: _searchQuery,
              onSearchChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              selectedSemester: _selectedSemester,
              semesters: allCourses.map((course) => course.semester).toSet().toList(),
              onSemesterChanged: (value) {
                setState(() {
                  _selectedSemester = value;
                });
              },
            ),
            const SizedBox(height: 24),
            Expanded(
              child: courseProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : courseProvider.errorMessage != null
                  ? Center(
                child: Text(
                  courseProvider.errorMessage!,
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
              )
                  : filteredCourses.isEmpty
                  ? const Center(
                child: Text(
                  'No courses found.',
                  style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
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