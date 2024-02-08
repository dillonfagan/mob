import 'package:flutter/material.dart';

class EndMobAlertDialog extends StatelessWidget {
  const EndMobAlertDialog({
    super.key,
    required this.onCancel,
    required this.onConfirm,
  });

  final Function() onCancel;
  final Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'End Mob',
        textScaleFactor: 2,
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          style: TextButton.styleFrom(foregroundColor: Colors.grey.shade200),
          child: const Text(
            'Cancel',
            textScaleFactor: 1.5,
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: const Text(
            'End Mob',
            textScaleFactor: 1.5,
          ),
        ),
      ],
      actionsPadding: const EdgeInsets.all(16),
    );
  }
}
