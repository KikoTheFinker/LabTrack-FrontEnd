class Validators {
  static String? validateUsername(String? value) {
    return (value == null || value.isEmpty)
        ? 'Please enter your username'
        : null;
  }

  static String? validatePassword(String? value) {
    return (value == null || value.isEmpty)
        ? 'Please enter your password'
        : null;
  }
}
