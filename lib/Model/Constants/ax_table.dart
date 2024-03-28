class AxTable {
  final String name;
  final int index;

  const AxTable._(this.name, this.index);

  static const AxTable none = AxTable._('None', 0);
  static const AxTable purchaseOrder = AxTable._('Purchase Order', 1);
  static const AxTable inventTable = AxTable._('Invent Table', 2);
  static const AxTable inventLocation = AxTable._('Invent Location', 3);

  static const List<AxTable> values = [
    none,
    purchaseOrder,
    inventTable,
    inventLocation,
  ];

  @override
  String toString() => name;
}