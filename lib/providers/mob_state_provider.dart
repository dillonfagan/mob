import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mob_app/providers/mob.dart';

class MobStateNotifier extends Notifier<MobState> {
  @override
  MobState build() {
    return MobState.waiting;
  }

  void update(MobState newState) {
    state = newState;
  }
}

final mobStateProvider =
    NotifierProvider<MobStateNotifier, MobState>(MobStateNotifier.new);
