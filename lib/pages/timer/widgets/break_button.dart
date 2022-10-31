import 'package:flutter/material.dart';

class BreakButton extends StatelessWidget {
  const BreakButton({
    super.key,
    required this.onPressed,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.timer_rounded,
        size: 36,
      ),
      label: const Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Text(
          'Take a Break',
          style: TextStyle(fontSize: 36),
        ),
      ),
      style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
    );
  }
}
