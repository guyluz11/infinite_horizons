part of 'package:infinite_horizons/domain/player_controller.dart';

class _PlayerRepository extends PlayerController {
  late AudioPlayer player;

  bool _isSilent = false;

  @override
  void initialize() {
    player = AudioPlayer();
  }

  @override
  Future play(String fileName) async {
    if (!_isSilent) {
      player.play(AssetSource('sound_effects/$fileName'));
    }
  }

  @override
  void setSilentState(bool value) => _isSilent = value;

  @override
  bool isSilent() => _isSilent;
}
