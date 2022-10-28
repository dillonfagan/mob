import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mob_app/common/log.dart';
import 'package:mob_app/pages/timer/widgets/appbar.dart';
import 'package:mob_app/pages/timer/widgets/control.dart';
import 'package:mob_app/providers/mob.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
        appBar: TimerAppBar(context: context),
        body: Center(
          child: Control(
            seconds: _secondsRemaining,
            isCounting: _isCounting,
            title: currentMobber.name,
            nextTitle: nextMobber.name,
            onNextPressed: _nextMobber,
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
        ));
  }
}
