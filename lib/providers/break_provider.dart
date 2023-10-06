import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mob_app/providers/turn_length_provider.dart';
import 'package:mob_app/providers/turns_provider.dart';

const int fortyFiveMinutes = 2700;

final breakProvider = Provider<bool>((ref) {
  final turns = ref.watch(turnsProvider);
  final turnLength = ref.watch(turnLengthProvider);

  return fortyFiveMinutes - turns * turnLength <= 0;
});
