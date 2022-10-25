import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mob_app/common/log.dart';
import 'package:mob_app/pages/setup/setup.dart';
import 'package:mob_app/pages/timer/widgets/display.dart';

class TimerPage extends StatefulWidget {
  TimerPage({super.key});

  final List<String> mobbers = ['Mobber 1', 'Mobber 2', 'Mobber 3'];

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final int startingSeconds = 5;

  late int secondsRemaining;
  late Timer timer;

  int _mobberIndex = 0;
  bool _isCounting = true;

  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() {
    secondsRemaining = startingSeconds;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      debug('Seconds Remaining: $secondsRemaining');
      setState(() {
        if (secondsRemaining < 1) {
          timer.cancel();
          setState(() => _isCounting = false);
        } else {
          secondsRemaining -= 1;
        }
      });
    });
  }

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
            TimerDisplay(seconds: secondsRemaining),
            const SizedBox(height: 16),
            _isCounting
                ? Text(
                    widget.mobbers[_mobberIndex],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 36),
                  )
                : ElevatedButton.icon(
                    onPressed: () {
                      _start();
                      setState(() {
                        _mobberIndex++;
                        _isCounting = true;
                      });
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: Text(
                      widget.mobbers[_mobberIndex + 1],
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
