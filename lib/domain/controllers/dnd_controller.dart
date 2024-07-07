import 'dart:io';

import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';

part 'package:infinite_horizons/infrastructure/dnd_repository.dart';

abstract class DndController {
  static DndController? _instance;

  static DndController get instance => _instance ??= _DndRepository();

  late bool supported;

  void init();

  Future<void> enableDnd();

  Future<bool> isDnd();
}
