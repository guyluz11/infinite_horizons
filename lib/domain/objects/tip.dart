import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:universal_io/io.dart';

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
    this.actionText, {
    required this.type,
    required this.timing,
    required this.icon,
    this.reason,
    this.selected = false,
    this.resourceLinks = const [],
    this.id,
    this.isCheckbox = true,
    this.startTimeFromWake,
    this.endTimeFromWake,
    this.startHour,
    this.endHour,
  }) {
    itemCountNumber = ++totalTipNumber;
  }

  static int totalTipNumber = 0;
  late int itemCountNumber;
  String? id;
  String actionText;
  String? reason;
  TipType type;
  TipTiming timing;
  bool selected;
  final List<Resource> resourceLinks;
  final bool isCheckbox;

  /// What time after the user woke up this tip should get shown
  Duration? startTimeFromWake;

  /// What time after the user woke up this tip should stop getting shown
  Duration? endTimeFromWake;

  /// Default start time to use if use does not grant or have wake times.
  DateTime? startHour;

  /// Default end time to use if use does not grant or have wake times.
  DateTime? endHour;

  IconData icon;

  bool isTipRecommendedNow({Duration? timeFromWake, DateTime? now}) {
    final DateTime nowVar = now ?? DateTime.now();

    if (timeFromWake != null) {
      if (startTimeFromWake != null && endTimeFromWake != null) {
        if (startTimeFromWake! <= timeFromWake &&
            endTimeFromWake! >= timeFromWake) {
          return true;
        }
        return false;
      }
    } else if (startTimeFromWake != null && endTimeFromWake != null) {
      if (startHour != null &&
          endHour != null &&
          nowVar.isAfter(startHour!) &&
          nowVar.isBefore(endHour!)) {
        return true;
      }
      return false;
    }

    return true;
  }
}

List<Tip> tipsList = [
  Tip(
    'Preferably close the app and go to sleep',
    reason:
        'Keeping awake at night will reduce your memory and thinking performance.',
    type: TipType.general,
    timing: TipTiming.before,
    icon: FontAwesomeIcons.phoneSlash,
    startTimeFromWake: const Duration(hours: 17),
    endTimeFromWake: const Duration(hours: 24),
    startHour: GlobalVariables.datTimeTodayOnlyHour(23),
    endHour: GlobalVariables.datTimeTodayOnlyHour(29),
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        "Go to Sleep to keep your sleep circle and brain in good state",
        link: Uri.parse('https://youtu.be/Ze2pc6NwsHQ?si=wXUetxQZKNsk4wXT'),
      ),
    ],
  ),

  /// General tips
  Tip(
    'dnd',
    reason: 'Increase focus',
    type: TipType.general,
    timing: TipTiming.before,
    icon: FontAwesomeIcons.circleMinus,
    id: 'dnd',
    isCheckbox:
        // We can toggle dnd on android so it is not always checkbox
        !Platform.isAndroid,
  ),
  Tip(
    'Sitting straight up',
    reason: 'Increase alertness',
    type: TipType.general,
    timing: TipTiming.before,
    icon: FontAwesomeIcons.userLarge,
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
    icon: FontAwesomeIcons.backwardStep,
  ),
  Tip(
    'Screen/book is being held at eye level',
    reason: 'Increase focus and alertness',
    type: TipType.general,
    timing: TipTiming.before,
    icon: FontAwesomeIcons.handPointRight,
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
    icon: FontAwesomeIcons.person,
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
  Tip(
    'Get expose to the sun or as much light as you can in the first 30m-60m of the day',
    reason: 'Facilitate focus',
    type: TipType.general,
    timing: TipTiming.before,
    icon: FontAwesomeIcons.sun,
    startTimeFromWake: Duration.zero,
    endTimeFromWake: const Duration(hours: 1),
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        "Getting expose to sun in the first 30m-60m of the day going to facilitate focus, further release of dopamine and norepinephrine and healthy amounts of cortisol.",
        link: Uri.parse('https://youtu.be/Ze2pc6NwsHQ?si=wXUetxQZKNsk4wXT'),
      ),
    ],
  ),
  Tip(
    'Sit in a sun lit environment and turn on as much lights as possible, open the windows',
    reason:
        'Increase focus, good for healthy brain productivity, reduce depression and insomnia',
    type: TipType.general,
    timing: TipTiming.before,
    icon: FontAwesomeIcons.solidLightbulb,
    startTimeFromWake: Duration.zero,
    endTimeFromWake: const Duration(hours: 9),
    startHour: GlobalVariables.datTimeTodayOnlyHour(5),
    endHour: GlobalVariables.datTimeTodayOnlyHour(12),
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        "Work environment with strong light without hurting your eyes in the first 9 hours of wake to increase focus and for releasing dopamine, norepinephrine, and healthy amounts of cortisol",
        link: Uri.parse('https://youtu.be/Ze2pc6NwsHQ?si=wXUetxQZKNsk4wXT'),
      ),
    ],
  ),

  Tip(
    'Reduce amount of exposure to light and especially over head light',
    reason: 'Improve sleep quality and overall health',
    type: TipType.general,
    timing: TipTiming.before,
    icon: FontAwesomeIcons.lightbulb,
    startTimeFromWake: const Duration(hours: 9),
    endTimeFromWake: const Duration(hours: 16),
    startHour: GlobalVariables.datTimeTodayOnlyHour(14),
    endHour: GlobalVariables.datTimeTodayOnlyHour(22),
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        "After 9 hours of being awake your should reducing over the head light inorder to shift body production from dopamine and norepinephrine to serotonin and other neuromodulators.",
        link: Uri.parse('https://youtu.be/Ze2pc6NwsHQ?si=wXUetxQZKNsk4wXT'),
      ),
    ],
  ),

  Tip(
    'Leave just the amount of light that allows you to do the work',
    reason:
        'To reduce severely depleting your melatonin and shifting your circadian clock',
    type: TipType.general,
    timing: TipTiming.before,
    icon: FontAwesomeIcons.moon,
    startTimeFromWake: const Duration(hours: 22),
    endTimeFromWake: const Duration(hours: 29),
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        "After 16 hours of being awake you should keep only the necessary light for the work, more than that will severely deplete your melatonin levels, going to severally shift your circadian clock like traveling to different time zone.",
        link: Uri.parse('https://youtu.be/Ze2pc6NwsHQ?si=wXUetxQZKNsk4wXT'),
      ),
    ],
  ),

  /// Analytical tips

  Tip(
    'Room with low ceiling or wearing a hat/hoodie',
    reason: 'Raises analytical thinking',
    type: TipType.analytical,
    timing: TipTiming.before,
    icon: FontAwesomeIcons.redhat,
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

  Tip(
    'Analytical',
    reason:
        'We are more Analytical in the morning as our brain is in a state of high alertness, accurate thinking, enhanced focus and cognitive functions',
    type: TipType.analytical,
    timing: TipTiming.before,
    icon: FontAwesomeIcons.magnifyingGlassChart,
    isCheckbox: false,
    id: 'recommended in the morning',
    startTimeFromWake: Duration.zero,
    endTimeFromWake: const Duration(hours: 9),
    startHour: GlobalVariables.datTimeTodayOnlyHour(8),
    endHour: GlobalVariables.datTimeTodayOnlyHour(12),
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        "In the first 9 hours after waking (around 8am-12pm) our brain enters state of high alertness and accurate thinking, which is good for working on analytical and accurate tasks.",
        link: Uri.parse('https://www.youtube.com/watch?v=Ze2pc6NwsHQ'),
      ),
    ],
  ),

  // Creatively tips
  Tip(
    'Creative',
    reason:
        'We are more Creative in the evening as our brain is in a state of divergent thinking and creativity',
    type: TipType.creative,
    timing: TipTiming.general,
    icon: FontAwesomeIcons.paintbrush,
    isCheckbox: false,
    id: 'recommended in the evening',
    startTimeFromWake: const Duration(hours: 11),
    endTimeFromWake: const Duration(hours: 20),
    startHour: GlobalVariables.datTimeTodayOnlyHour(14),
    endHour: GlobalVariables.datTimeTodayOnlyHour(23),
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity',
        'In the evening (around 14pm onward) our brain thinks in a creative way',
        link: Uri.parse('https://www.youtube.com/watch?v=Ze2pc6NwsHQ'),
      ),
    ],
  ),
  Tip(
    'Environment with high ceiling or outside',
    reason:
        'Raises abstract thinking, creative thinking, and increase aspirations',
    type: TipType.creative,
    timing: TipTiming.before,
    icon: FontAwesomeIcons.landmark,
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
    'Work for 90m to maximize concentration efficiency',
    type: TipType.general,
    timing: TipTiming.general,
    icon: FontAwesomeIcons.graduationCap,
    id: '90m concentrated',
    resourceLinks: [
      Resource(
        'YouTube video by Andrew Huberman: "Optimizing Workspace for Productivity, Focus, & Creativity"',
        'Andrew Huberman recommends working for 90m to maximize study efficiency',
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
    icon: FontAwesomeIcons.glasses,
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
