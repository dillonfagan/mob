import 'package:flutter/material.dart';
import 'package:mob_app/models/mobber.dart';

class MobProvider extends ChangeNotifier {
  List<Mobber> _mobbers = [];

  List<Mobber> get mobbers => _mobbers;

  set mobbers(List<Mobber> newMobbers) {
    _mobbers = newMobbers;
    notifyListeners();
  }
}
