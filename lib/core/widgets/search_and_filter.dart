import 'package:flutter/material.dart';
import '../theme/theme.dart';

class SearchAndFilterBar extends StatelessWidget {
  final String searchQuery;
  final Function(String) onSearchChanged;
  final int? selectedSemester;
  final List<int> semesters;
  final Function(int?) onSemesterChanged;

  const SearchAndFilterBar({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.selectedSemester,
    required this.semesters,
    required this.onSemesterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            hintText: 'Search courses...',
            prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: 24),
        DropdownButton<int>(
          value: selectedSemester,
          hint: const Text('Filter by Semester'),
          isExpanded: true,
          icon:
              const Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
          underline: const SizedBox(),
          borderRadius: BorderRadius.circular(12),
          style: const TextStyle(fontSize: 16, color: Colors.black),
          items: [
            const DropdownMenuItem<int>(
              value: null,
              child: Text('All Semesters'),
            ),
            ...semesters.map(
              (semester) => DropdownMenuItem<int>(
                value: semester,
                child: Text('Semester $semester'),
              ),
            ),
          ],
          onChanged: onSemesterChanged,
        ),
      ],
    );
  }
}
