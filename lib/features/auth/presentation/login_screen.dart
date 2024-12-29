import 'package:flutter/material.dart';
import 'package:lab_track/features/auth/auth.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/animated_fade_widget.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/toggle_password_field.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  void _handleLogin(BuildContext context) {
    final username = usernameController.text;
    final password = passwordController.text;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.login(username, password)) {
      print('Login successful');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username or password'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LabTrack'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  AnimatedFadeWidget(
                    child: Image.asset(
                      'lib/assets/images/logo.png',
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const AnimatedFadeWidget(
                    child: Text(
                      "Track your laboratory exercises",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: Validators.validateUsername,
                        ),
                        const SizedBox(height: 16),
                        TogglePasswordField(
                          controller: passwordController,
                          labelText: 'Password',
                          validator: Validators.validatePassword,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0099FF),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _handleLogin(context);
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                "© 2024 LabTrack - All rights reserved",
                style: TextStyle(color: Colors.blueGrey, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
