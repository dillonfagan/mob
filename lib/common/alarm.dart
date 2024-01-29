import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class Alarm {
  static final AudioPlayer audioPlayer = AudioPlayer(playerId: '#alarm');

  void play() async {
    if (kDebugMode) {
      return;
    }

    await audioPlayer.play(
      UrlSource('sounds/alarm.mp3'),
      volume: 1.0,
    );
  }
}
