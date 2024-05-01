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
  final List<Uri> resourceLinks;
}

List<Tip> tipsList = [
  /// General tips
  Tip(0, 'Siting straight up'),
  Tip(1, 'Screen/book is being hold in eye level'),

  /// Analytical tips
  Tip(
    2,
    'Room with low ceiling or hat/hoodie',
    resourceLinks: [Uri.parse('https://assets.csom.umn.edu/assets/71190.pdf')],
  ),

  // Creatively tips
  Tip(
    3,
    'Environment with high ceiling or outside',
    resourceLinks: [Uri.parse('https://assets.csom.umn.edu/assets/71190.pdf')],
  ),
];
