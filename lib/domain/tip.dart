class Tip {
  Tip(this.id, this.text, {this.selected = false});

  int id;
  String text;
  bool selected;
}

List<Tip> tipsList = [
  /// General tips
  Tip(0, 'Siting straight up'),
  Tip(1, 'Screen/book is being hold in eye level'),

  /// Analytical tips
  Tip(2, 'Room with low ceiling or hat/hoody'),

  // Creatively tips
  Tip(3, 'Environment with high ceiling or outside'),
];
