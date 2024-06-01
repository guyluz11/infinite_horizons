import 'package:audioplayers/audioplayers.dart';

part 'package:infinite_horizons/infrastructure/player_repository.dart';

abstract class PlayerController {
  static PlayerController? _instance;

  static PlayerController get instance => _instance ??= _PlayerRepository();

  void setIsSound(bool value);

  bool isSound();

  void initialize();

  Future play(String fileName);
}
