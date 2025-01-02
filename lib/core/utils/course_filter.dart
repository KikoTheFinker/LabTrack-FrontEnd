import '../../features/points/models/course.dart';

List<Course> filterCourses({
  required List<Course> courses,
  required String searchQuery,
  int? selectedSemester,
}) {
  return courses.where((course) {
    final matchesSemester =
        selectedSemester == null || course.semester == selectedSemester;
    final matchesSearch = searchQuery.isEmpty ||
        course.name.toLowerCase().contains(searchQuery.toLowerCase());
    return matchesSemester && matchesSearch;
  }).toList();
}
