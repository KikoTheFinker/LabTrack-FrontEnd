import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lab_track/core/theme/theme.dart';
import 'package:lab_track/features/points/models/course.dart';
import 'package:provider/provider.dart';

import '../../../../state/course_students_provider.dart';

class ProfessorCourseDetailsScreen extends StatefulWidget {
  final Course course;

  const ProfessorCourseDetailsScreen({super.key, required this.course});

  @override
  State<ProfessorCourseDetailsScreen> createState() =>
      _ProfessorCourseDetailsScreenState();
}

class _ProfessorCourseDetailsScreenState
    extends State<ProfessorCourseDetailsScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "token");

    if (token != null) {
      Provider.of<CourseStudentsProvider>(context, listen: false)
          .fetchStudentsForCourse(widget.course.id, token);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseStudentsProvider = Provider.of<CourseStudentsProvider>(context);
    final filteredStudents = courseStudentsProvider.students.where((student) {
      return _searchQuery.isEmpty ||
          student.username.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.name),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search student index...',
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.primaryColor),
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
          ),
          Expanded(
            child: courseStudentsProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : courseStudentsProvider.errorMessage != null
                    ? Center(
                        child: Text(
                          courseStudentsProvider.errorMessage!,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      )
                    : filteredStudents.isEmpty
                        ? const Center(child: Text('No students found.'))
                        : ListView.builder(
                            itemCount: filteredStudents.length,
                            itemBuilder: (context, index) {
                              final student = filteredStudents[index];
                              return ListTile(
                                title:
                                    Text("${student.name} ${student.surname}"),
                                subtitle: Text('Index: ${student.username}'),
                                trailing: const Icon(Icons.chevron_right),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
