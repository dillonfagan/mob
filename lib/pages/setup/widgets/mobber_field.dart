import 'package:flutter/material.dart';

class MobberField extends StatelessWidget {
  const MobberField({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Add a mobber...',
      ),
      onSubmitted: onSubmitted,
    );
  }
}
