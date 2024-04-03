class NoYes {
  final String name;
  final int index;

  const NoYes._(this.name, this.index);

  static const NoYes no = NoYes._('No', 0);
  static const NoYes yes = NoYes._('Yes', 1);
  static const NoYes none = NoYes._('None', 2);

  static const List<NoYes> values = [
    no,
    yes,
    none,
  ];

  @override
  String toString() => name;
}