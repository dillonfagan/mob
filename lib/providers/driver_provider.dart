import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mob_app/models/mobber.dart';
import 'package:mob_app/providers/mobbers_provider.dart';

class DriverIndexNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void reset() {
    state = 0;
  }

  void next() {
    if (state == ref.read(mobbersProvider).length - 1) {
      state = 0;
    } else {
      state++;
    }
  }
}

final driverIndexProvider =
    NotifierProvider<DriverIndexNotifier, int>(DriverIndexNotifier.new);

final driverProvider = Provider<Mobber>((ref) {
  final driverIndex = ref.watch(driverIndexProvider);
  final mobbers = ref.watch(mobbersProvider);

  return mobbers[driverIndex];
});

final navigatorProvider = Provider<Mobber>((ref) {
  final driverIndex = ref.watch(driverIndexProvider);
  final mobbers = ref.watch(mobbersProvider);

  final navigatorIndex =
      driverIndex == mobbers.length - 1 ? 0 : driverIndex + 1;

  return mobbers[navigatorIndex];
});
