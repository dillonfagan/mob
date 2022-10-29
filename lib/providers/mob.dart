import 'package:flutter/material.dart';
import 'package:mob_app/models/mobber.dart';

class MobProvider extends ChangeNotifier {
  List<Mobber> _mobbers = [];
  int _currentMobberIndex = 0;
  int _turns = 0;

  int get turns => _turns;

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

  Mobber get currentMobber => _mobbers[_currentMobberIndex];

  Mobber get nextMobber => _mobbers[_nextMobberIndex];

  List<Mobber> get mobbers => _mobbers;

  void advanceTurn() {
    _turns++;
    _currentMobberIndex = _nextMobberIndex;
    notifyListeners();
  }

  int get _nextMobberIndex {
    if (_currentMobberIndex == _mobbers.length - 1) {
      return 0;
    }

    return _currentMobberIndex + 1;
  }

  set mobbers(List<Mobber> newMobbers) {
    _mobbers = newMobbers;
    notifyListeners();
  }
}
