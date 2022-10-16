import 'package:flutter/material.dart';
import 'package:mob_app/pages/timer/timer.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SetupPageState();
  }
}

class _SetupPageState extends State<SetupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.start),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) {
                  return const TimerPage();
                }),
              ));
            },
          ),
        ),
      ),
    );
  }
}
