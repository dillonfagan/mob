import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final secondsProvider = StateProvider<int>((ref) => 0);

final timerProvider = StateProvider<Timer>((ref) {
  return Timer.periodic(const Duration(seconds: 1), (timer) {
    timer.cancel();
  });
});

Timer getTimer(Ref ref, Function() onStop) {
  return Timer.periodic(
    const Duration(seconds: 1),
    (timer) {
      ref.read(secondsProvider.notifier).state -= 1;

      if (ref.read(secondsProvider) == 0) {
        onStop();
      }
    },
  );
}
