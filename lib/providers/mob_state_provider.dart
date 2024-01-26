import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mob_app/providers/mob_controller_provider.dart';

class MobStateNotifier extends Notifier<MobState> {
  @override
  MobState build() {
    return MobState.initialLoad;
  }

  void update(MobState newState) {
    state = newState;
  }
}

final mobStateProvider =
    NotifierProvider<MobStateNotifier, MobState>(MobStateNotifier.new);
