import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mobber.dart';

class Mobbers extends Notifier<List<Mobber>> {
  @override
  List<Mobber> build() {
    return [];
  }

  void add(Mobber mobber) {
    state = [...state, mobber];
  }

  void removeAt(int index) {
    final temp = state;
    temp.removeAt(index);

    state = [...temp];
  }

  void shuffle() {
    final temp = state;
    temp.shuffle();

    state = [...temp];
  }
}

final mobbersProvider = NotifierProvider<Mobbers, List<Mobber>>(Mobbers.new);
