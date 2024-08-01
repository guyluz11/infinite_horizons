import 'package:infinite_horizons/domain/objects/tip.dart';
import 'package:infinite_horizons/domain/objects/work_type_abstract.dart';

class WorkTypeCreatively extends WorkTypeAbstract {
  WorkTypeCreatively() : super(TipType.creative);

  @override
  List<Tip> getTips() => tipsList
      .where(
        (element) =>
            element.type == TipType.general || element.type == TipType.creative,
      )
      .toList();
}
