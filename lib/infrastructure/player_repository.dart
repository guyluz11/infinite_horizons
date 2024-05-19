part of 'package:infinite_horizons/domain/player_controller.dart';

class _PlayerRepository extends PlayerController {
  late AudioPlayer player;

  @override
  void initialize() {
    player = AudioPlayer();
  }

  @override
  Future play(String fileName) async =>
      player.play(AssetSource('sound_effects/$fileName'));
}
