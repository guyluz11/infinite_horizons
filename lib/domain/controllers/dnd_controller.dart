import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:infinite_horizons/domain/controllers/permissions_controller.dart';

part 'package:infinite_horizons/infrastructure/dnd_repository.dart';

abstract class DndController {
  static DndController? _instance;

  static DndController get instance => _instance ??= _DndRepository();

  Future<void> enableDnd();
  Future<bool> isDnd();
}
