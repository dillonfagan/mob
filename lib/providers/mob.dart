import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mob_app/providers/driver_provider.dart';
import 'package:mob_app/providers/mob_state_provider.dart';
import 'package:mob_app/providers/turns_provider.dart';

const int fortyFiveMinutes = 2700;

enum MobState {
  mobbing,
  waiting,
  onBreak,
}

class MobController {
  const MobController(this.ref);

  final Ref ref;

  void reset() {
    ref.read(turnsProvider.notifier).reset();
    ref.read(driverIndexProvider.notifier).reset();
    ref.read(mobStateProvider.notifier).update(MobState.waiting);
  }
}

final mobControllerProvider = Provider(MobController.new);
