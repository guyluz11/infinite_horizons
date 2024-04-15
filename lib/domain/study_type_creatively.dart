import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/tip.dart';

class StudyTypeCreatively extends StudyTypeAbstract {
  StudyTypeCreatively() : super(StudyType.creatively);

  @override
  List<Tip> getTips() {
    if (tips.isEmpty) {
      tips = <Tip>[
            tipsList[3],
          ] +
          super.getTips();
    }
    return tips;
  }
}
