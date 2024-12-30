import 'package:flutter/material.dart';
import 'package:lab_track/core/widgets/logout_popup.dart';
import 'package:lab_track/features/auth/auth.dart';
import 'package:provider/provider.dart';
import '../models/student.dart';

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
    final filteredCourses = student.courses.where((course) {
      final matchesSemester =
          _selectedSemester == null || course.semester == _selectedSemester;
      final matchesSearch = _searchQuery.isEmpty ||
          course.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesSemester && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
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
            TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                hintText: 'Search courses...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 24),
            DropdownButton<int>(
              value: _selectedSemester,
              hint: const Text('Filter by Semester'),
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              underline: const SizedBox(),
              borderRadius: BorderRadius.circular(12),
              style: const TextStyle(fontSize: 16, color: Colors.black),
              items: [
                const DropdownMenuItem<int>(
                  value: null,
                  child: Text('All Semesters'),
                ),
                ...{...student.courses.map((course) => course.semester)}
                    .map((semester) => DropdownMenuItem<int>(
                          value: semester,
                          child: Text('Semester $semester'),
                        )),
              ],
              onChanged: (value) {
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
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredCourses.length,
                      itemBuilder: (context, index) {
                        final course = filteredCourses[index];
                        return MouseRegion(
                          onEnter: (_) {
                            setState(() {});
                          },
                          onExit: (_) {
                            setState(() {});
                          },
                          child: Container(
                            height: 110,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                title: Text(
                                  course.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                subtitle: Text(
                                  'Semester ${course.semester}',
                                  style: const TextStyle(color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.blueAccent,
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/course_details',
                                    arguments: course,
                                  );
                                },
                                tileColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
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
