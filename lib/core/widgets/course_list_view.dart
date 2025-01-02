import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../../features/points/models/course.dart';

class CourseListView extends StatelessWidget {
  final List<Course> courses;
  final void Function(Course course) onCourseTap;

  const CourseListView({
    super.key,
    required this.courses,
    required this.onCourseTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Container(
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Text(
                'Semester ${course.semester}',
                style: const TextStyle(
                    color: AppColors.primaryColor, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.secondaryColor,
              ),
              onTap: () => onCourseTap(course),
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
        );
      },
    );
  }
}
