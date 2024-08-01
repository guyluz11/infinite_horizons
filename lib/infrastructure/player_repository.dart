part of 'package:infinite_horizons/domain/controllers/player_controller.dart';

class _PlayerRepository extends PlayerController {
  late AudioPlayer player;

  bool _isSound = true;

  @override
  void init() => player = AudioPlayer();

  @override
  Future play(SoundType type) async {
    if (_isSound) {
      player.play(AssetSource('sound_effects/${type.fileName}'));
    }
  }

  @override
  void setIsSound(bool value) => _isSound = value;

  @override
  bool isSound() => _isSound;
}
