import 'package:flutter/material.dart';
import 'package:mob_app/pages/setup/setup.dart';

void main() {
  runApp(const MobApp());
}

class MobApp extends StatelessWidget {
  const MobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const SetupPage(),
    );
  }
}
