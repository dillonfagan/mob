import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerProvider = StateProvider<int>((ref) => 0);

final newTimerProvider = StateProvider<Timer>((ref) {
  return Timer.periodic(const Duration(seconds: 1), (timer) {
    timer.cancel();
  });
});

Timer getTimer(Ref ref, Function() onStop) {
  return Timer.periodic(
    const Duration(seconds: 1),
    (timer) {
      ref.read(timerProvider.notifier).state -= 1;

      if (ref.read(timerProvider) == 0) {
        onStop();
      }
    },
  );
}
