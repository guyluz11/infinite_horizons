part 'package:infinite_horizons/infrastructure/player_repository.dart';

abstract class PlayerController {
  static PlayerController? _instance;

  static PlayerController get instance {
    return _instance ??= _PlayerRepository();
  }

  Future play(String path);
}

enum VibrationType { light, medium, heavy }
