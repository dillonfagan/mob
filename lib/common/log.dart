import 'package:flutter/foundation.dart';

void debug(String message) {
  if (kDebugMode) {
    print(message);
  }
}
