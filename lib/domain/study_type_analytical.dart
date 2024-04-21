import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/tip.dart';

class StudyTypeAnalytical extends StudyTypeAbstract {
  StudyTypeAnalytical() : super(StudyType.analytically);

  @override
  List<Tip> getTips() {
    if (tips.isEmpty) {
      tips = <Tip>[
            tipsList[2],
          ] +
          super.getTips();
    }
    return tips;
  }
}
