part of 'package:infinite_horizons/domain/player_controller.dart';

class _PlayerRepository extends PlayerController {
  late AudioPlayer player;

  bool isSilent = false;

  @override
  void initialize() {
    player = AudioPlayer();
  }

  @override
  Future play(String fileName) async {
    if (!isSilent) {
      player.play(AssetSource('sound_effects/$fileName'));
    }
  }

  @override
  void setSilentState(bool value) => isSilent = value;

  @override
  bool getSilentState() => isSilent;
}
