class StudyTypeAbstract {
  StudyTypeAbstract(this.studyType);

  static StudyTypeAbstract? _instance;

  static StudyTypeAbstract get instance {
    return _instance ??= StudyTypeAbstract(StudyType.undefined);
  }

  StudyType studyType;
}

enum StudyType {
  undefined,
  analytically,
  creatively,
  ;
}

extension StudyTypeExtension on StudyType {
  static StudyType fromString(String typeAsString) {
    return StudyType.values.firstWhere(
      (element) => element.toString().split('.').last == typeAsString,
      orElse: () => StudyType.undefined,
    );
  }
}
