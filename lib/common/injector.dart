import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get_it/get_it.dart';
import 'package:retro_tv_cars/common/audio_controller.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();
  GetIt _getItInstance;

  factory Injector() {
    return _singleton;
  }

  Injector._internal() {
    _getItInstance = GetIt.instance;
  }

  static GetIt _getIt() {
    return _singleton._getItInstance;
  }

  static init() {
    _getIt().registerSingleton(_singleton._createAudioController());
  }

  AudioController _createAudioController() {
    return AudioController(AssetsAudioPlayer());
  }

  static AudioController get audioController => _getIt()<AudioController>();
}
