class PurchLineDto {
  final String itemId;
  final int lineNumber;
  final String itemName;
  final double purchQty;
  final String purchUnit;
  final double purchPrice;
  final double lineAmount;

  PurchLineDto({
    this.itemId = '',
    this.lineNumber = 0,
    this.itemName = '',
    this.purchQty = 0,
    this.purchUnit = '',
    this.purchPrice = 0,
    this.lineAmount = 0
  });

  factory PurchLineDto.fromJson(Map<String, dynamic> json) => PurchLineDto(
    itemId: json['itemId'] as String? ?? '',
    lineNumber: json['lineNumber'] as int? ?? 0,
    itemName: json['itemName'] as String? ?? '',
    purchQty: json['purchQty'] as double? ?? 0,
    purchUnit: json['purchUnit'] as String? ?? '',
    purchPrice: json['purchPrice'] as double? ?? 0,
    lineAmount: json['lineAmount'] as double? ?? 0,
  );

  Map<String, dynamic> toJson() => {
    if (itemId.isNotEmpty) 'itemId': itemId,
    if (lineNumber != 0) 'lineNumber': lineNumber,
    if (itemName.isNotEmpty) 'itemName': itemName,
    if (purchQty != 0) 'purchQty': purchQty,
    if (purchUnit.isNotEmpty) 'purchUnit': purchUnit,
    if (purchPrice != 0) 'purchPrice': purchPrice,
    if (lineAmount != 0) 'lineAmount': lineAmount,
  };
}