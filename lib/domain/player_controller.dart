import 'package:audioplayers/audioplayers.dart';

part 'package:infinite_horizons/infrastructure/player_repository.dart';

abstract class PlayerController {
  static PlayerController? _instance;

  static PlayerController get instance {
    return _instance ??= _PlayerRepository();
  }

  void initialize();

  Future play(String fileName);
}
