// import 'package:flutter/material.dart';
// import 'package:lab_track/core/theme/theme.dart';
// import 'package:lab_track/core/utils/data_holder.dart';
// import 'package:lab_track/features/points/models/student.dart';
// import 'package:lab_track/features/points/models/course.dart';
//
// import '../../../../core/widgets/edit_points_dialog.dart';
// import 'package:provider/provider.dart';
//
// class StudentDetailsScreen extends StatefulWidget {
//   final Student student;
//   final Course course;
//
//   const StudentDetailsScreen({
//     super.key,
//     required this.student,
//     required this.course,
//   });
//
//   @override
//   State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
// }
//
// class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Student: ${widget.student.username}',
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//         ),
//         backgroundColor: AppColors.primaryColor,
//       ),
//       body: Consumer<DataHolder>(
//         builder: (context, dataHolder, child) {
//           final course = DataHolder.courses.firstWhere(
//                 (c) => c.id == widget.course.id,
//           );
//
//           return ListView.builder(
//             itemCount: course.laboratoryExercises?.length ?? 0,
//             itemBuilder: (context, index) {
//               final lab = course.laboratoryExercises?[index];
//               final currentPoints =
//                   lab?.studentPoints[widget.student.username] ?? "Not graded";
//
//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 3,
//                 child: ListTile(
//                   title: Text(
//                     lab!.name,
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w500),
//                   ),
//                   subtitle: Text(
//                     'Current Points: $currentPoints / ${lab.maxPoints}',
//                     style: TextStyle(color: Colors.grey[600]),
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.edit, color: AppColors.primaryColor),
//                     onPressed: () async {
//                       final newPoints = await editPointsDialog(
//                         context,
//                         currentPoints,
//                         lab.maxPoints,
//                         lab.name,
//                       );
//                       if (newPoints != null) {
//                         dataHolder.updateStudentPoints(
//                           course: course,
//                           lab: lab,
//                           studentUsername: widget.student.username,
//                           newPoints: newPoints,
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
