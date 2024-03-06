
class InventTableSearchDto {
  final String itemId;
  final String productName;
  final String searchName;

  InventTableSearchDto({
    this.itemId = '',
    this.productName = '',
    this.searchName = '',
  });

  factory InventTableSearchDto.fromJson(Map<String, dynamic> json) => InventTableSearchDto(
    itemId: json['itemId'] as String,
    productName: json['productName'] as String,
    searchName: json['searchName'] as String,
  );

  Map<String, dynamic> toJson() => {
    if (itemId.isNotEmpty) 'itemId': itemId,
    if (productName.isNotEmpty) 'productName': productName,
    if (searchName.isNotEmpty) 'searchName': searchName,
  };
}