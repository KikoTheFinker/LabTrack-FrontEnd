import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/auth_provider.dart';
import 'logout_popup.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout, color: Colors.white),
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return LogoutPopup(
              onLogout: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .logout(context);
                Navigator.pushReplacementNamed(context, '/');
              },
            );
          },
        );
      },
    );
  }
}
