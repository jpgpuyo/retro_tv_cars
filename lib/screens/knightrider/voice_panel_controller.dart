class VoicePanelController {
  VoicePanelController();

  List<int> lightsToEnable(double value, int offset) {
    if (value > 0 && value <= 1.0) {
      return [9];
    } else if (value > 1.0 && value <= 3.0) {
      return [8, 9, 10];
    } else if (((value + offset) > 3.0) && (value + offset <= 4.0)) {
      return [7, 8, 9, 10, 11];
    } else if (((value + offset) > 4.0) && (value + offset <= 5.0)) {
      return [6, 7, 8, 9, 10, 11, 12];
    } else if (((value + offset) > 5.0) && (value + offset <= 7.0)) {
      return [5, 6, 7, 8, 9, 10, 11, 12, 13];
    } else {
      return [];
    }
  }
}
