import 'package:flutter/material.dart';

class LaboratoryExercise {
  final int assignmentId;
  final int exerciseId;
  final String exerciseName;
  final DateTime exerciseDate;
  final int exerciseMaxPoints;
  final String studentPoints;
  final TimeDetails timeDetails;

  LaboratoryExercise({
    required this.assignmentId,
    required this.exerciseId,
    required this.exerciseName,
    required this.exerciseDate,
    required this.exerciseMaxPoints,
    required this.studentPoints,
    required this.timeDetails,
  });

  factory LaboratoryExercise.fromJson(Map<String, dynamic> json) {
    return LaboratoryExercise(
      assignmentId: json['assignment_id'],
      exerciseId: json['exercise_id'],
      exerciseName: json['exercise_name'],
      exerciseDate: DateTime.parse(json['exercise_date']),
      exerciseMaxPoints: json['exercise_max_points'],
      studentPoints: json['student_points'] == null
          ? "Not Graded"
          : json['student_points'] is int
          ? json['student_points'].toString()
          : json['student_points'],
      timeDetails: TimeDetails.fromJson(json['time_details']),
    );
  }
}

class TimeDetails {
  final int timeDetailsId;
  final String groupName;
  final String room;
  final TimeOfDay time;

  TimeDetails({
    required this.timeDetailsId,
    required this.groupName,
    required this.room,
    required this.time,
  });

  factory TimeDetails.fromJson(Map<String, dynamic> json) {
    return TimeDetails(
      timeDetailsId: json['time_details_id'],
      groupName: json['group_name'],
      room: json['room'],
      time: _parseTime(json['time']),
    );
  }

  static TimeOfDay _parseTime(String timeString) {
    List<String> parts = timeString.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
