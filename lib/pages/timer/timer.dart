import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mob_app/pages/timer/helpers/ticker.dart';
import 'package:mob_app/providers/break_provider.dart';
import 'package:mob_app/providers/driver_provider.dart';
import 'package:mob_app/providers/mob_controller_provider.dart';
import 'package:mob_app/providers/mob_state_provider.dart';
import 'package:mob_app/providers/turn_length_provider.dart';

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
  late final _ticker = Ticker(
    onTick: _update,
    onStop: _playChime,
  );

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _ticker.stop();
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  void _start({int? seconds}) {
    setState(() => _ticker.start(seconds ?? ref.read(turnLengthProvider)));
  }

  void _stop() {
    setState(() => _ticker.stop());
  }

  void _playChime() async {
    await widget.audioPlayer.play(
      AssetSource('sounds/chime.wav'),
      volume: 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final timeToBreak = ref.watch(breakProvider);
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
            TimerDisplay(seconds: _ticker.secondsRemaining),
            const SizedBox(height: 16),
            _ticker.isActive
                ? Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 36),
                  )
                : timeToBreak
                    ? BreakButton(
                        onPressed: () {
                          ref
                              .read(mobStateProvider.notifier)
                              .update(MobState.onBreak);
                          _start(seconds: 600);
                        },
                      )
                    : NextButton(
                        labelText: navigator.name,
                        onPressed: () {
                          ref
                              .read(mobStateProvider.notifier)
                              .update(MobState.mobbing);
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
            ref.read(mobStateProvider.notifier).update(MobState.waiting);
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
