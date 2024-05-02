class Resource {
  Resource(this.title, this.resourceExplanation, {this.link});

  Uri? link;
  String title;
  String resourceExplanation;
}

class Tip {
  Tip(
    this.id,
    this.text, {
    this.selected = false,
    this.resourceLinks = const [],
  });

  int id;
  String text;
  bool selected;
  final List<Resource> resourceLinks;
}

List<Tip> tipsList = [
  /// General tips
  Tip(
    0,
    'Siting straight up',
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        "Our body react differently based on it's relation to gravity.\nWhile moving it is very alert, less while standing, less while sitting, leaning back even more, and lying down really puts you into sleep mode.",
        link: Uri.parse('https://youtu.be/Ze2pc6NwsHQ?si=wXUetxQZKNsk4wXT'),
      ),
    ],
  ),
  Tip(
    1,
    'Screen/book is being hold in eye level',
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        'If the eyeball is pointing down then we become less focused and more tired, if we point upwards the level of concentration increases.\nIt is better holding at eye level or above to stay focused.',
        link: Uri.parse('https://youtu.be/Ze2pc6NwsHQ?si=wXUetxQZKNsk4wXT'),
      ),
    ],
  ),
  Tip(
    4,
    'Alternate back and forth siting and standing while working about 50/50 of your total sessions for the day',
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
    2,
    'Room with low ceiling or wearing a hat/hoodie',
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
    3,
    'Environment with high ceiling or outside',
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
];
