import 'package:infinite_horizons/domain/objects/tip.dart';
import 'package:infinite_horizons/domain/objects/work_type_abstract.dart';

class WorkTypeAnalytical extends WorkTypeAbstract {
  WorkTypeAnalytical() : super(TipType.analytical);

  @override
  List<Tip> getTips() => tipsList
      .where(
        (element) =>
            element.type == TipType.general ||
            element.type == TipType.analytical,
      )
      .toList();
}
