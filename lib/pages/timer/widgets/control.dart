import 'package:flutter/material.dart';

import 'display.dart';

class Control extends StatelessWidget {
  const Control({
    super.key,
    required this.seconds,
    required this.isCounting,
    required this.title,
    required this.nextTitle,
    required this.onNextPressed,
  });

  final int seconds;
  final bool isCounting;
  final String title;
  final String nextTitle;
  final Function() onNextPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TimerDisplay(seconds: seconds),
        const SizedBox(height: 16),
        isCounting
            ? Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 36),
              )
            : ElevatedButton.icon(
                onPressed: onNextPressed,
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 36,
                ),
                label: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Text(
                    nextTitle,
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              ),
      ],
    );
  }
}
