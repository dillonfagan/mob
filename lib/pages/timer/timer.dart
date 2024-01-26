import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mob_app/providers/break_provider.dart';
import 'package:mob_app/providers/driver_provider.dart';
import 'package:mob_app/providers/mob_controller_provider.dart';
import 'package:mob_app/providers/mob_state_provider.dart';
import 'package:mob_app/providers/timer_provider.dart';
import 'package:mob_app/providers/turn_length_provider.dart';
import 'package:mob_app/providers/turns_provider.dart';

import 'widgets/appbar_factory.dart';
import 'widgets/break_button.dart';
import 'widgets/display.dart';
import 'widgets/next_button.dart';

class TimerPage extends ConsumerStatefulWidget {
  TimerPage({super.key});

  final AudioPlayer audioPlayer = AudioPlayer(playerId: '#timer');

  @override
  ConsumerState<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends ConsumerState<TimerPage> {
  late Timer _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
    timer.cancel();
  });

  void _start({int? seconds}) {
    ref.read(timerProvider.notifier).state =
        seconds ?? ref.read(turnLengthProvider);

    setState(() {
      _ticker = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          ref.read(timerProvider.notifier).state -= 1;

          if (ref.read(timerProvider) == 0) {
            _playAlarm();
            _stop();
          }
        },
      );
    });
  }

  void _stop() {
    setState(() => _ticker.cancel());

    if (ref.read(mobStateProvider) == MobState.onBreak) {
      ref.read(mobControllerProvider).reset();
    } else {
      ref.read(turnsProvider.notifier).state += 1;
    }

    final timeToBreak = ref.watch(breakProvider);
    if (timeToBreak) {
      ref.read(mobStateProvider.notifier).update(MobState.timeToBreak);
      return;
    }

    ref.read(mobStateProvider.notifier).update(MobState.waiting);
  }

  void _playAlarm() async {
    if (kDebugMode) {
      return;
    }

    await widget.audioPlayer.play(
      UrlSource('sounds/alarm.mp3'),
      volume: 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mobState = ref.watch(mobStateProvider);
    final driver = ref.watch(driverProvider);
    final navigator = ref.watch(navigatorProvider);
    String title = mobState == MobState.onBreak ? 'Break' : driver.name;

    return Scaffold(
      appBar: AppBarFactory.build(
        context: context,
        controller: ref.read(mobControllerProvider),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TimerDisplay(seconds: ref.watch(timerProvider)),
            const SizedBox(height: 16),
            if (mobState == MobState.initialLoad)
              StartButton(onPressed: () {
                ref.read(mobStateProvider.notifier).update(MobState.mobbing);
                _start();
              }),
            if (mobState == MobState.mobbing || mobState == MobState.onBreak)
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 36),
              ),
            if (mobState == MobState.timeToBreak)
              BreakButton(
                onPressed: () {
                  ref.read(mobStateProvider.notifier).update(MobState.onBreak);
                  _start(seconds: 600);
                },
              ),
            if (mobState == MobState.waiting)
              NextButton(
                labelText: navigator.name,
                onPressed: () {
                  ref.read(mobStateProvider.notifier).update(MobState.mobbing);
                  ref.read(driverIndexProvider.notifier).next();
                  _start();
                },
              ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: _ticker.isActive,
        child: FloatingActionButton(
          onPressed: () {
            _stop();
          },
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
