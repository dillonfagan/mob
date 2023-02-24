import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mob_app/pages/timer/helpers/ticker.dart';
import 'package:mob_app/providers/mob.dart';
import 'package:provider/provider.dart';

import 'widgets/appbar_factory.dart';
import 'widgets/break_button.dart';
import 'widgets/display.dart';
import 'widgets/next_button.dart';

class TimerPage extends StatefulWidget {
  TimerPage({super.key, this.seconds = 5});

  final int seconds;
  final AudioPlayer audioPlayer = AudioPlayer(playerId: '#timer');

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
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
    setState(() => _ticker.start(seconds ?? widget.seconds));
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
    final mob = Provider.of<MobProvider>(context);
    final currentMobber = mob.currentMobber;
    final nextMobber = mob.nextMobber;
    String title = mob.isOnBreak ? 'Break' : currentMobber.name;

    return Scaffold(
      appBar: AppBarFactory.build(context: context),
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
                : mob.isTimeForBreak
                    ? BreakButton(
                        onPressed: () {
                          mob.state = MobState.onBreak;
                          _start(seconds: 600);
                        },
                      )
                    : NextButton(
                        labelText: nextMobber.name,
                        onPressed: () {
                          mob.state = MobState.mobbing;
                          mob.advanceTurn();
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
            mob.state = MobState.waiting;
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
