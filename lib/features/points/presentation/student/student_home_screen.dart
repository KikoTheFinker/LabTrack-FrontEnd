import 'package:flutter/material.dart';
import 'package:lab_track/core/widgets/logout_popup.dart';
import 'package:lab_track/features/auth/auth.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/course_filter.dart';
import '../../../../core/widgets/course_list_view.dart';
import '../../../../core/widgets/search_and_filter.dart';
import '../../models/student.dart';
import 'course_details_screen.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  String _searchQuery = '';
  int? _selectedSemester;

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AuthProvider>(context).currentUser;
    if (currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/');
      });
      return const Scaffold();
    }
    final student = currentUser as Student;

    final filteredCourses = filterCourses(
      courses: student.courses,
      searchQuery: _searchQuery,
      selectedSemester: _selectedSemester,
    );

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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return LogoutPopup(
                    onLogout: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .logout(context);
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  );
                },
              );
            },
          ),
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
              semesters: [
                ...{...student.courses.map((course) => course.semester)}
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
                            builder: (context) => CourseDetailsScreen(
                              course: course,
                              studentId: currentUser.username.toString(),
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
