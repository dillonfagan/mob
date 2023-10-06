import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mob_app/pages/setup/setup.dart';

void main() {
  runApp(const ProviderScope(child: MobApp()));
}

class MobApp extends StatelessWidget {
  const MobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mob Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(primary: Colors.amber),
      ),
      home: const SetupPage(),
    );
  }
}
