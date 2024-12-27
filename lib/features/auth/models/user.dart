enum UserRole { student, assistant, professor }

class User {
  final int id;
  final String username;
  final String password;
  final UserRole role;

  User(
      {required this.id,
      required this.username,
      required this.password,
      required this.role});
}
