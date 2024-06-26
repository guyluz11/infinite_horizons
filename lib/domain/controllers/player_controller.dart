import 'package:audioplayers/audioplayers.dart';

part 'package:infinite_horizons/infrastructure/player_repository.dart';

abstract class PlayerController {
  static PlayerController? _instance;

  static PlayerController get instance => _instance ??= _PlayerRepository();

  void init();

  void setIsSound(bool value);

  bool isSound();

  Future play(SoundType type);
}

enum SoundType {
  startSession('start_session.wav'),
  sessionCompleted('session_completed.wav'),
  breakEnded('break_ended.wav'),
  checkBoxChecked('writing_on_a_book_with_a_pen_signing_v.wav'),
  strikethrough('straight_line_whoosh_pen_on_paper.wav'),
  ;

  const SoundType(this.fileName);

  final String fileName;
}
