import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mob_app/common/log.dart';
import 'package:mob_app/providers/mob.dart';
import 'package:provider/provider.dart';

import 'widgets/appbar.dart';
import 'widgets/display.dart';
import 'widgets/next_button.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key, this.seconds = 5});

  final int seconds;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late int _secondsRemaining;
  late Timer _timer;

  bool _isCounting = true;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _start() {
    _secondsRemaining = widget.seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      debug('Seconds Remaining: $_secondsRemaining');
      setState(() {
        if (_secondsRemaining < 1) {
          _stop();
        } else {
          _secondsRemaining -= 1;
        }
      });
    });
  }

  void _stop() {
    _timer.cancel();
    setState(() {
      _secondsRemaining = 0;
      _isCounting = false;
    });
  }

  void _nextMobber() {
    _start();
    setState(() => _isCounting = true);
  }

  @override
  Widget build(BuildContext context) {
    final mob = Provider.of<MobProvider>(context);
    final currentMobber = mob.currentMobber;
    final nextMobber = mob.nextMobber;
    String title = currentMobber.name;

    return Scaffold(
      appBar: TimerAppBar(context: context),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TimerDisplay(seconds: _secondsRemaining),
            const SizedBox(height: 16),
            _isCounting
                ? Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 36),
                  )
                : NextButton(
                    labelText: nextMobber.name,
                    onPressed: () {
                      mob.advanceTurn();
                      _nextMobber();
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: _isCounting,
        child: FloatingActionButton(
          onPressed: _stop,
          backgroundColor: Colors.amber,
          child: const Icon(
            Icons.skip_next_rounded,
            size: 36,
          ),
        ),
      ),
    );
  }
}
