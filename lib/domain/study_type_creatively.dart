import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/tip.dart';

class StudyTypeCreatively extends StudyTypeAbstract {
  StudyTypeCreatively() : super(TipType.creative);

  @override
  List<Tip> getTips() => tipsList
      .where((element) =>
          element.type == TipType.general || element.type == TipType.creative)
      .toList();
}
