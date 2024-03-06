
class InventTableDto {
  final String itemId;
  final String productName;
  final String searchName;
  final String description;
  final String productType;
  final String productionType;
  final String image;

  InventTableDto({
    this.itemId = '',
    this.productName = '',
    this.searchName = '',
    this.description = '',
    this.productType = '',
    this.productionType = '',
    this.image = '',
  });

  factory InventTableDto.fromJson(Map<String, dynamic> json) => InventTableDto(
    itemId: json['itemId'] as String,
    productName: json['productName'] as String,
    searchName: json['searchName'] as String,
    description: json['description'] as String,
    productType: json['productType'] as String,
    productionType: json['productionType'] as String,
    image: json['image'] as String,
  );

  Map<String, dynamic> toJson() => {
    if (itemId.isNotEmpty) 'itemId': itemId,
    if (productName.isNotEmpty) 'productName': productName,
    if (searchName.isNotEmpty) 'searchName': searchName,
    if (description.isNotEmpty) 'description': description,
    if (productType.isNotEmpty) 'productType': productType,
    if (productionType.isNotEmpty) 'productionType': productionType,
    if (image.isNotEmpty) 'image': image,
  };
}