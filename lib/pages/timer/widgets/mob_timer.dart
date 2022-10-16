import 'dart:async';
import 'package:flutter/material.dart';

class MobTimer extends StatefulWidget {
  MobTimer({super.key, required this.onStopped});

  Function() onStopped;

  @override
  State<MobTimer> createState() => _MobTimerState();
}

class _MobTimerState extends State<MobTimer> {
  int _secondsRemaining = 5;
  late Timer timer;

  @override
  void initState() {
    _start();
    super.initState();
  }

  void _start() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining < 1) {
          timer.cancel();
          widget.onStopped();
        } else {
          _secondsRemaining -= 1;
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duration = Duration(seconds: _secondsRemaining);
    final minutes = _formatTimeDigits(duration.inMinutes);
    final seconds = _formatTimeDigits(
        _secondsRemaining > 61 ? duration.inSeconds % 60 : duration.inSeconds);

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
