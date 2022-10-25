import 'package:flutter/material.dart';
import 'package:mob_app/models/mobber.dart';

class MobProvider extends ChangeNotifier {
  List<Mobber> _mobbers = [];

  int get turnLength {
    if (_mobbers.isEmpty) {
      return 0;
    }

    if (_mobbers.length == 1) {
      return 900;
    }

    if (_mobbers.length < 4) {
      return 480;
    }

    return 420;
  }

  List<Mobber> get mobbers => _mobbers;

  set mobbers(List<Mobber> newMobbers) {
    _mobbers = newMobbers;
    notifyListeners();
  }
}
