import 'package:flutter/material.dart';

class EndMobAlertDialog extends StatelessWidget {
  const EndMobAlertDialog({super.key, required this.onConfirm});

  final Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('End Mob'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(foregroundColor: Colors.grey.shade200),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onConfirm,
          child: const Text('End Mob'),
        ),
      ],
    );
  }
}
