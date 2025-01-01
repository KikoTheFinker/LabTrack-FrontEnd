import 'package:flutter/material.dart';
import '../theme/theme.dart';

class LabDetail extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const LabDetail({super.key, required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primaryColor,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
