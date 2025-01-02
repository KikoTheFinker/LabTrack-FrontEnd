
import 'package:flutter/material.dart';

Future<int?> editPointsDialog(
    BuildContext context,
    Object currentPoints,
    int maxPoints,
    String labName,
    ) {
  final TextEditingController controller =
  TextEditingController(text: currentPoints.toString());

  return showDialog<int>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit Points for $labName'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Points (Max: $maxPoints)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              final int? newPoints = int.tryParse(controller.text);
              if (newPoints != null && newPoints <= maxPoints) {
                Navigator.of(context).pop(newPoints);
              }
            },
          ),
        ],
      );
    },
  );
}
