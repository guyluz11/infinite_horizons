class Resource {
  Resource(this.title, this.resourceExplanation, {this.link});

  String title;
  String resourceExplanation;
  Uri? link;
}

enum TipType {
  undefined('undefined'),
  general('general'),
  analytical('analytical'),
  creative('creative'),
  ;

  const TipType(this.name);
  final String name;
}

extension TipTypeExtension on TipType {
  static TipType fromString(String typeAsString) {
    return TipType.values.firstWhere(
      (element) => element.toString().split('.').last == typeAsString,
      orElse: () => TipType.undefined,
    );
  }
}

enum TipTiming {
  general('general'),
  before('before'),
  inSession('in_session'),
  inBreak('in_break'),
  after('after'),
  ;

  const TipTiming(this.name);
  final String name;
}

class Tip {
  Tip(
    this.text, {
    required this.type,
    required this.timing,
    this.selected = false,
    this.resourceLinks = const [],
    this.id,
  }) {
    itemCountNumber = ++totalTipNumber;
  }

  static int totalTipNumber = 0;
  late int itemCountNumber;
  String? id;
  String text;
  TipType type;
  TipTiming timing;
  bool selected;
  final List<Resource> resourceLinks;
}

List<Tip> tipsList = [
  /// General tips
  Tip(
    'dnd',
    type: TipType.general,
    timing: TipTiming.before,
    id: 'dnd',
  ),
  Tip(
    'Siting straight up',
    type: TipType.general,
    timing: TipTiming.before,
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        "Our body react differently based on it's relation to gravity.\nWhile moving it is very alert, less while standing, less while sitting, leaning back even more, and lying down really puts you into sleep mode.",
        link: Uri.parse('https://youtu.be/Ze2pc6NwsHQ?si=wXUetxQZKNsk4wXT'),
      ),
    ],
  ),
  Tip(
    'start_by',
    type: TipType.general,
    timing: TipTiming.inSession,
  ),
  Tip(
    'Screen/book is being hold in eye level',
    type: TipType.general,
    timing: TipTiming.before,
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        'If the eyeball is pointing down then we become less focused and more tired, if we point upwards the level of concentration increases.\nIt is better holding at eye level or above to stay focused.',
        link: Uri.parse('https://youtu.be/Ze2pc6NwsHQ?si=wXUetxQZKNsk4wXT'),
      ),
    ],
  ),
  Tip(
    'Alternate back and forth siting and standing 50/50',
    type: TipType.general,
    timing: TipTiming.inSession,
    resourceLinks: [
      Resource(
        'Scientific paper: "Effects of a Workplace Sit–Stand Desk Intervention on Health and Productivity"',
        'Improvement in cognitive conditioning and ability to embrace new tasks and cognitive performance.\nReduce neck and shoulder pain, increase in subjective health vitality in a work-related environments',
        link: Uri.parse('https://www.mdpi.com/1660-4601/18/21/11604'),
      ),
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        "Our body react differently based on it's relation to gravity.\nWhile moving it is very alert, less while standing, less while sitting, leaning back even more, and lying down really puts you into sleep mode.",
        link: Uri.parse('https://youtu.be/Ze2pc6NwsHQ?si=wXUetxQZKNsk4wXT'),
      ),
    ],
  ),

  /// Analytical tips
  Tip(
    'recommended_morning',
    type: TipType.analytical,
    timing: TipTiming.general,
    id: 'recommended in the morning',
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity',
        'We think more analytically in the morning and creative in the evening',
        link: Uri.parse('https://www.youtube.com/watch?v=Ze2pc6NwsHQ'),
      ),
    ],
  ),
  Tip(
    'Room with low ceiling or wearing a hat/hoodie',
    type: TipType.analytical,
    timing: TipTiming.before,
    resourceLinks: [
      Resource(
        'Scientific paper: "The Influence of Ceiling Height: The Effect of Priming on the Type of Processing That People Use"',
        'A low ceiling raises analytical thinking in the close environment.\nAlso known as "the cathedral effect".',
        link: Uri.parse('https://assets.csom.umn.edu/assets/71190.pdf'),
      ),
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        'You can switch room and environment based on your study work needs.\nThe cathedral effect got observed in the language and words the people in the studies used and also the ideas they came up with.',
        link: Uri.parse('https://youtu.be/Ze2pc6NwsHQ?si=wXUetxQZKNsk4wXT'),
      ),
    ],
  ),

  // Creatively tips
  Tip(
    'recommended_evening',
    type: TipType.creative,
    timing: TipTiming.general,
    id: 'recommended in the evening',
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity',
        'We think more analytically in the morning and creative in the evening',
        link: Uri.parse('https://www.youtube.com/watch?v=Ze2pc6NwsHQ'),
      ),
    ],
  ),
  Tip(
    'Environment with high ceiling or outside',
    type: TipType.creative,
    timing: TipTiming.before,
    resourceLinks: [
      Resource(
        'Scientific paper: "The Influence of Ceiling Height: The Effect of Priming on the Type of Processing That People Use"',
        'A high ceiling raises abstract thinking, creative thinking, and increase aspirations.\nAlso known as "the cathedral effect".',
        link: Uri.parse('https://assets.csom.umn.edu/assets/71190.pdf'),
      ),
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        'You can switch room and environment based on your study work needs.\nThe cathedral effect got observed in the language and words the people in the studies used and also the ideas they came up with.',
        link: Uri.parse('https://youtu.be/Ze2pc6NwsHQ?si=wXUetxQZKNsk4wXT'),
      ),
    ],
  ),
  Tip(
    'Study for 90m to maximize concentration efficiency',
    type: TipType.general,
    timing: TipTiming.general,
    id: '90m concentrated',
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        'Andrew Huberman recommends studying for 90m to maximize study efficiency',
        link: Uri.parse(
          'https://youtu.be/Ze2pc6NwsHQ?si=VVlKkS7f6Fxtu00r&t=2534',
        ),
      ),
    ],
  ),
  Tip(
    'Take a 5m break in panoramic area for every 45m for healthy eyesight',
    type: TipType.general,
    timing: TipTiming.inBreak,
    id: '45m/5m',
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        'Take a 5m break for every 45m in which you are focusing on something. The break should be out side and with panoramic/field of view to let your eyes change focus and rest, looking at close objects like phone or book will cancel the health benefits effect. This is important to the health of the eye muscles to keep functioning correctly to reduce the change of requiring a glasses or increasing lens size.',
        link: Uri.parse(
          'https://youtu.be/Ze2pc6NwsHQ?si=VVlKkS7f6Fxtu00r&t=2534',
        ),
      ),
    ],
  ),
];
