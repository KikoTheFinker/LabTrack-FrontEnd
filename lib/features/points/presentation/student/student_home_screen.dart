import 'package:flutter/material.dart';
import 'package:lab_track/core/theme/theme.dart';
import 'package:lab_track/core/widgets/course_list_view.dart';
import 'package:lab_track/core/widgets/logout_button.dart';
import 'package:lab_track/core/widgets/search_and_filter.dart';
import 'package:lab_track/features/points/models/laboratory_exercise.dart';
import 'package:provider/provider.dart';

import '../../../../state/auth_provider.dart';
import '../../../../state/course_details_provider.dart';
import '../../../../state/course_provider.dart';
import '../../models/course.dart';
import 'student_course_details_screen.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  String _searchQuery = '';
  int? _selectedSemester;

  @override
  void initState() {
    super.initState();
    Provider.of<CourseProvider>(context, listen: false).fetchCourses(context);
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    final allCourses = courseProvider.courses;

    List<Course> filteredCourses = allCourses.where((course) {
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
          'My Courses',
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
                onCourseTap: (course) async {
                  final courseDetailsProvider =
                  Provider.of<CourseDetailsProvider>(context, listen: false);

                  await courseDetailsProvider.fetchStudentLaboratoryExercises(context, course.id);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseDetailsScreen(
                        laboratoryExercises: courseDetailsProvider.laboratoryExercises,
                        courseId: course.id,
                        studentId: Provider.of<AuthProvider>(context, listen: false).token.toString(),
                        courseName: course.name,
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
