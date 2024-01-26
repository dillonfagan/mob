import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mob_app/providers/driver_provider.dart';
import 'package:mob_app/providers/mob_state_provider.dart';
import 'package:mob_app/providers/timer_provider.dart';
import 'package:mob_app/providers/turns_provider.dart';

import 'break_provider.dart';

const int fortyFiveMinutes = 2700;

enum MobState {
  initialLoad,
  mobbing,
  waiting,
  timeToBreak,
  onBreak,
}

class MobController {
  MobController(this.ref);

  final Ref ref;

  final AudioPlayer audioPlayer = AudioPlayer(playerId: '#timer');

  void _playAlarm() async {
    if (kDebugMode) {
      return;
    }

    await audioPlayer.play(
      UrlSource('sounds/alarm.mp3'),
      volume: 1.0,
    );
  }

  void pause() {
    ref.read(newTimerProvider).cancel();
  }

  void resume() {
    ref.read(newTimerProvider.notifier).state = getTimer(ref, () {
      _playAlarm();
      endTurn();
    });
  }

  void endTurn() {
    ref.read(newTimerProvider).cancel();

    if (ref.read(mobStateProvider) == MobState.onBreak) {
      reset();
    } else {
      ref.read(turnsProvider.notifier).state += 1;
    }

    final timeToBreak = ref.read(breakProvider);
    if (timeToBreak) {
      ref.read(mobStateProvider.notifier).update(MobState.timeToBreak);
      return;
    }

    ref.read(mobStateProvider.notifier).update(MobState.waiting);
  }

  void reset() {
    ref.read(turnsProvider.notifier).state = 0;
    ref.read(driverIndexProvider.notifier).reset();
    ref.read(mobStateProvider.notifier).update(MobState.initialLoad);
  }
}

final mobControllerProvider = Provider(MobController.new);
