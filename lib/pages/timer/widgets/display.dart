import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key, required this.seconds});

  final int seconds;

  @override
  Widget build(BuildContext context) {
    final duration = Duration(seconds: this.seconds);
    final minutes = _formatTimeDigits(duration.inMinutes);
    final seconds = _formatTimeDigits(
        this.seconds > 61 ? duration.inSeconds % 60 : duration.inSeconds);

    return Text(
      '$minutes:$seconds',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 80,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String _formatTimeDigits(int number) {
    return number.toString().padLeft(2, '0');
  }
}
