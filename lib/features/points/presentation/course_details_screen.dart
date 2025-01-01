import 'package:flutter/material.dart';
import 'package:lab_track/core/theme/theme.dart';
import 'package:lab_track/core/widgets/lab_detail.dart';
import 'package:lab_track/features/points/models/course.dart';

class CourseDetailsScreen extends StatefulWidget {
  final Course course;
  final String studentId;

  const CourseDetailsScreen({
    super.key,
    required this.course,
    required this.studentId,
  });

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  int? expandedLabId;

  void toggleLabDetails(int labId) {
    setState(() {
      expandedLabId = (expandedLabId == labId) ? null : labId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 56,
            pinned: true,
            backgroundColor: AppColors.primaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 56, bottom: 8),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'LABORATORY EXERCISES',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.course.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              centerTitle: false,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final lab = widget.course.laboratoryExercises![index];
                final studentPoints =
                    lab.studentPoints[widget.studentId] ?? "Not graded";
                final isExpanded = expandedLabId == lab.id;
                final progress = studentPoints == "Not graded"
                    ? 0.0
                    : double.parse(studentPoints.toString()) / lab.maxPoints;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: Card(
                      elevation: isExpanded ? 4 : 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: isExpanded
                              ? AppColors.primaryColor
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => toggleLabDetails(lab.id),
                            borderRadius: BorderRadius.circular(15),
                            splashColor: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryColor
                                              .withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${lab.id}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              lab.name,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              lab.dateTime
                                                  .toLocal()
                                                  .toString()
                                                  .split(' ')[0],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        isExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: AppColors.primaryColor,
                                      ),
                                    ],
                                  ),
                                  if (!isExpanded) ...[
                                    const SizedBox(height: 12),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        value: progress,
                                        backgroundColor: Colors.grey[200],
                                        valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          AppColors.primaryColor,
                                        ),
                                        minHeight: 6,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            child: isExpanded
                                ? Container(
                              decoration: BoxDecoration(
                                color: AppColors.secondaryColor
                                    .withOpacity(0.1),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: LabDetail(
                                          icon: Icons.calendar_today,
                                          title: 'Date',
                                          value: lab.dateTime
                                              .toLocal()
                                              .toString()
                                              .split(' ')[0],
                                        ),
                                      ),
                                      Expanded(
                                        child: LabDetail(
                                          icon: Icons.access_time,
                                          title: 'Time',
                                          value: lab.dateTime
                                              .toLocal()
                                              .toString()
                                              .split(' ')[1]
                                              .substring(0, 5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Points',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            child:
                                            LinearProgressIndicator(
                                              value: progress,
                                              backgroundColor:
                                              Colors.grey[200],
                                              valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(
                                                AppColors.primaryColor,
                                              ),
                                              minHeight: 20,
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Center(
                                              child: Text(
                                                '$studentPoints / ${lab.maxPoints}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                                : Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: widget.course.laboratoryExercises?.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}