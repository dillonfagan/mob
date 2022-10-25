import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mob_app/common/log.dart';
import 'package:mob_app/pages/setup/setup.dart';
import 'package:mob_app/pages/timer/widgets/display.dart';
import 'package:mob_app/providers/mob.dart';
import 'package:provider/provider.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key, this.seconds = 5});

  final int seconds;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late int secondsRemaining;
  late Timer timer;
  late List<String> mobbers;

  int _mobberIndex = 0;
  bool _isCounting = true;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _start() {
    secondsRemaining = widget.seconds;
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

  void _nextMobber() {
    _start();
    setState(() {
      _mobberIndex = _nextMobberIndex;
      _isCounting = true;
    });
  }

  int get _nextMobberIndex {
    if (_mobberIndex == mobbers.length - 1) {
      return 0;
    }

    return _mobberIndex + 1;
  }

  @override
  Widget build(BuildContext context) {
    final mob = Provider.of<MobProvider>(context);
    final mobbers = mob.mobbers;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => const SetupPage(),
          )),
          icon: const Icon(Icons.close_rounded),
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
                    mobbers[_mobberIndex].name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 36),
                  )
                : ElevatedButton.icon(
                    onPressed: () => _nextMobber(),
                    icon: const Icon(Icons.arrow_forward),
                    label: Text(
                      mobbers[_nextMobberIndex].name,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
