import 'package:assets_audio_player/assets_audio_player.dart';

class AudioController {
  final AssetsAudioPlayer assetsAudioPlayer;

  AudioController(this.assetsAudioPlayer);

  void playKnightRiderMainTheme() {
    assetsAudioPlayer.stop();
    assetsAudioPlayer.open(Audio("assets/knight_rider_main_theme.mp3"));
  }

  void playBackToTheFutureMainTheme() {
    assetsAudioPlayer.stop();
    assetsAudioPlayer.open(Audio("assets/back_to_the_future_main_theme.mp3"));
  }

  void stop() {
    assetsAudioPlayer.stop();
  }

  void dispose() {
    assetsAudioPlayer.dispose();
  }
}
