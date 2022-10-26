import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mob_app/common/log.dart';
import 'package:mob_app/models/mobber.dart';
import 'package:mob_app/pages/setup/setup.dart';
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
  late List<Mobber> _mobbers;

  int _mobberIndex = 0;
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
    setState(() {
      _mobberIndex = _nextMobberIndex;
      _isCounting = true;
    });
  }

  int get _nextMobberIndex {
    if (_mobberIndex == _mobbers.length - 1) {
      return 0;
    }

    return _mobberIndex + 1;
  }

  @override
  Widget build(BuildContext context) {
    final mob = Provider.of<MobProvider>(context);
    _mobbers = mob.mobbers;

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
        actions: [
          IconButton(
            onPressed: () => _stop(),
            icon: const Icon(Icons.start),
          ),
        ],
      ),
      body: Center(
        child: Control(
          seconds: _secondsRemaining,
          isCounting: _isCounting,
          title: _mobbers[_mobberIndex].name,
          nextTitle: _mobbers[_nextMobberIndex].name,
          onNextPressed: _nextMobber,
        ),
      ),
    );
  }
}
