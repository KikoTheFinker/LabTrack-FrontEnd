import 'package:flutter/material.dart';

class TogglePasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;

  const TogglePasswordField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
  });

  @override
  _TogglePasswordFieldState createState() => _TogglePasswordFieldState();
}

class _TogglePasswordFieldState extends State<TogglePasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: const Icon(Icons.lock),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      obscureText: !_isPasswordVisible,
      validator: widget.validator,
    );
  }
}
