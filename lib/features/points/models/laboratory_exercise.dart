class LaboratoryExercise {
  final int id;
  final String name;
  final DateTime dateTime;
  final Map<String, int> studentPoints;
  final int maxPoints;

  LaboratoryExercise({
    required this.id,
    required this.name,
    required this.dateTime,
    required this.studentPoints,
    required this.maxPoints,
  });
}
