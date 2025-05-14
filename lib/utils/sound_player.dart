import 'package:audioplayers/audioplayers.dart';

class SoundPlayer {
  static final _player = AudioPlayer();

  static Future<void> playClick() async {
    await _player.play(AssetSource('sounds/click.mp3'));
  }

  static Future<void> playWin() async {
    await _player.play(AssetSource('sounds/win.mp3'));
  }
}