import 'package:flutter/material.dart';
import 'package:mob_app/pages/setup/setup.dart';
import 'package:mob_app/pages/timer/widgets/mob_timer.dart';

class TimerPage extends StatefulWidget {
  TimerPage({super.key});

  final List<String> mobbers = ['Mobber 1', 'Mobber 2'];

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  bool _isCounting = true;
  int mobberIndex = 0;

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
            MobTimer(
              onStopped: () {
                setState(() => _isCounting = false);
              },
            ),
            const SizedBox(height: 16),
            _isCounting
                ? Text(
                    widget.mobbers[mobberIndex],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 36),
                  )
                : ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward),
                    label: Text(
                      widget.mobbers[mobberIndex + 1],
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
