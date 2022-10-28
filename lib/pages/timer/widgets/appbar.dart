import 'package:flutter/material.dart';
import 'package:mob_app/pages/setup/setup.dart';

// ignore: non_constant_identifier_names
AppBar TimerAppBar({required BuildContext context}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const SetupPage(),
      )),
      icon: const Icon(Icons.close_rounded),
    ),
  );
}
