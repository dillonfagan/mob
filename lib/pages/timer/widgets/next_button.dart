import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.labelText,
    required this.onPressed,
  });

  final String labelText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.arrow_forward_rounded,
        size: 36,
      ),
      label: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Text(
          labelText,
          style: const TextStyle(fontSize: 36),
        ),
      ),
      style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
    required this.onPressed,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.play_arrow,
        size: 36,
      ),
      label: const Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Text(
          'Start',
          style: TextStyle(fontSize: 36),
        ),
      ),
      style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
    );
  }
}
