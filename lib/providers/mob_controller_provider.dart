import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mob_app/common/alarm.dart';
import 'package:mob_app/providers/driver_provider.dart';
import 'package:mob_app/providers/mob_state_provider.dart';
import 'package:mob_app/providers/timer_provider.dart';
import 'package:mob_app/providers/turns_provider.dart';

import 'break_provider.dart';
import 'turn_length_provider.dart';

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

  final _alarm = Alarm();

  bool get isTurnSkippable {
    final state = ref.read(mobStateProvider);
    return state == MobState.mobbing ||
        state == MobState.onBreak ||
        state == MobState.waiting;
  }

  void start() {
    ref.read(mobStateProvider.notifier).update(MobState.mobbing);
    ref.read(secondsProvider.notifier).state = ref.read(turnLengthProvider);
    resume();
  }

  void startNextTurn() {
    ref.read(driverIndexProvider.notifier).next();
    start();
  }

  void startBreak() {
    ref.read(mobStateProvider.notifier).update(MobState.onBreak);
    ref.read(secondsProvider.notifier).state = 600;
    resume();
  }

  void skipTurn() {
    ref.read(driverIndexProvider.notifier).next();
  }

  void pause() {
    ref.read(timerProvider).cancel();
  }

  void resume() {
    if (ref.read(mobStateProvider) == MobState.initialLoad) {
      return;
    }

    ref.read(timerProvider.notifier).state = getTimer(ref, () {
      _alarm.play();
      endTurn();
    });
  }

  void endTurn() {
    ref.read(timerProvider).cancel();

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
