import 'package:flutter/material.dart';
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
    if (currentUser == null){
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
      appBar: AppBar(
        title: const Text('My Courses'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout(context);
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search courses...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButton<int>(
              value: _selectedSemester,
              hint: const Text('Filter by Semester'),
              isExpanded: true,
              items: [
                const DropdownMenuItem(
                    value: null, child: Text('All Semesters')),
                ...{...student.courses.map((course) => course.semester)}
                    .map((semester) => DropdownMenuItem(
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
            const SizedBox(height: 16),
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
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(course.name),
                            subtitle: Text('Semester ${course.semester}'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/course_details',
                                arguments: course,
                              );
                            },
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
