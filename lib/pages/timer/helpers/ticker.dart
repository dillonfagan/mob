import 'dart:async';

import 'package:mob_app/common/log.dart';

class Ticker {
  Ticker({required this.onTick, this.onStop});

  final Function() onTick;
  final Function()? onStop;

  late Timer _timer;
  late int _secondsRemaining;

  int get secondsRemaining => _secondsRemaining;

  bool get isActive => _timer.isActive;

  void start(int seconds) {
    _secondsRemaining = seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      debug('Seconds Remaining: $_secondsRemaining');
      if (_secondsRemaining < 1) {
        stop();
        onStop?.call();
      } else {
        _secondsRemaining -= 1;
      }
      onTick();
    });
  }

  void stop() {
    _secondsRemaining = 0;
    _timer.cancel();
  }
}
