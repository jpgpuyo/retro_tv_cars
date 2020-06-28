import 'package:flutter/material.dart';
import 'package:retro_tv_cars/common/audio_controller.dart';

import 'voice_panel_controller.dart';
import 'models.dart';

class KnightRiderModel extends ChangeNotifier {
  Mode currentMode;
  VoicePanelController voicePanelController;
  AudioController audioController;

  KnightRiderModel(
      this.currentMode, this.voicePanelController, this.audioController);

  void setMode(Mode mode) {
    this.currentMode = mode;
    notifyListeners();
  }

  List<int> lightsToEnable(double value, int offset) {
    if (currentMode == Mode.pursuit) {
      return voicePanelController.lightsToEnable(value, offset);
    } else {
      return [];
    }
  }

  void playMainTheme() {
    this.audioController.playKnightRiderMainTheme();
  }

  void stopPlaying() {
    this.audioController.stop();
  }

  void dipose() {
    this.audioController.dispose();
  }
}
