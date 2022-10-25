import 'package:flutter/material.dart';
import 'package:mob_app/pages/setup/setup.dart';
import 'package:mob_app/providers/mob.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MobApp());
}

class MobApp extends StatelessWidget {
  const MobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context, child) {
        return MaterialApp(
          title: 'Mob Timer',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: const ColorScheme.dark(primary: Colors.amber),
          ),
          home: const SetupPage(),
        );
      },
      create: (BuildContext context) => MobProvider(),
    );
  }
}
