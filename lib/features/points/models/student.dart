class Student {
  final int id;
  final String name;
  final String surname;
  final String username;

  Student({
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
  });

  factory Student.fromJson(Map<String, dynamic> studentData) {
    return Student(
      id: studentData['id'],
      name: studentData['name'],
      surname: studentData['surname'],
      username: studentData['username'],

    );
  }
}
