import 'package:flutter/material.dart';
import 'package:mob_app/pages/setup/setup.dart';
import 'package:mob_app/pages/timer/widgets/mob_timer.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => const SetupPage(),
          )),
          icon: const Icon(Icons.close),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const MobTimer(),
            const Text(
              'Dillon',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 36),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.arrow_right),
              label: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
