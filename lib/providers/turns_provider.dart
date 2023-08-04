import 'package:flutter_riverpod/flutter_riverpod.dart';

class TurnsNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void reset() {
    state = 0;
  }
}

final turnsProvider = NotifierProvider<TurnsNotifier, int>(TurnsNotifier.new);
