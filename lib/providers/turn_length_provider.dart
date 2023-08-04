import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mobbers_provider.dart';

final turnLengthProvider = Provider<int>((ref) {
  final mobbers = ref.watch(mobbersProvider);

  if (mobbers.isEmpty) {
    return 0;
  }

  if (kDebugMode) {
    return 2;
  }

  if (mobbers.length == 1) {
    return 900;
  }

  if (mobbers.length < 4) {
    return 480;
  }

  return 420;
});
