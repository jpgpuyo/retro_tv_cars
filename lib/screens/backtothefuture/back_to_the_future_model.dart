import 'package:flutter/material.dart';
import 'package:retro_tv_cars/common/audio_controller.dart';

class BackToTheFutureModel extends ChangeNotifier {
  AudioController audioController;

  BackToTheFutureModel(this.audioController);

  void playMainTheme() {
    this.audioController.playBackToTheFutureMainTheme();
  }

  void stopPlaying() {
    this.audioController.stop();
  }

  void dispose() {
    this.audioController.dispose();
  }
}
