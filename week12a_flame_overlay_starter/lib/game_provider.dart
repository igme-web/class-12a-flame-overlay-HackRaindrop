import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class GameProvider extends ChangeNotifier {
  // Private variables for settings
  double _musicVolume = 1.0;
  double _sfxVolume = 1.0;
  int _score = 0;
  int _lastScore = 0;
  bool _inGame = false;

  // Getters to access private variables
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;
  int get score => _score;
  int get lastScore => _lastScore;
  bool get inGame => _inGame;

  //Audio players
  AudioPlayer musicPlayer = AudioPlayer();
  AudioPlayer sfxPlayer = AudioPlayer();

  final AudioContext audioContext = AudioContextConfig(
    focus: AudioContextConfigFocus.mixWithOthers,
  ).build();

  // Setters with notifyListeners
  void setMusicVolume(double value) {
    _musicVolume = value;
    musicPlayer.setVolume(_musicVolume);
    notifyListeners();
  }

  void setSfxVolume(double value) {
    _sfxVolume = value;
    sfxPlayer.setVolume(_sfxVolume);
    notifyListeners();
  }

  void incrementScore(int value) {
    _score += value;
    notifyListeners();
  }

  void setLastScore(int value) {
    _lastScore = value;
    notifyListeners();
  }

  Future<void> playBgm(String url) async {
    musicPlayer.setAudioContext(audioContext);
    musicPlayer.setReleaseMode(ReleaseMode.loop);
    await musicPlayer.play(AssetSource(url));
  }

  Future<void> playSfx(String url) async {
    await sfxPlayer.play(AssetSource(url));
  }

  @override
  void dispose() {
    musicPlayer.dispose();
    sfxPlayer.dispose();
    super.dispose();
  }
}
