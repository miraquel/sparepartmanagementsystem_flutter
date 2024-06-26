import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/product_type.dart';

class GoodsReceiptLineDto
{
  final int goodsReceiptLineId;
  final int goodsReceiptHeaderId;
  final String itemId;
  final int lineNumber;
  final String itemName;
  final ProductType productType;
  final double remainPurchPhysical;
  final double receiveNow;
  final double purchQty;
  final String purchUnit;
  final double purchPrice;
  final double lineAmount;
  final String inventLocationId;
  final String wMSLocationId;
  final String createdBy;
  final DateTime createdDateTime;
  final String modifiedBy;
  final DateTime modifiedDateTime;

  GoodsReceiptLineDto({
    this.goodsReceiptLineId = 0,
    this.goodsReceiptHeaderId = 0,
    this.itemId = '',
    this.lineNumber = 0,
    this.itemName = '',
    this.productType = ProductType.none,
    this.remainPurchPhysical = 0,
    this.receiveNow = 0,
    this.purchQty = 0,
    this.purchUnit = '',
    this.purchPrice = 0,
    this.lineAmount = 0,
    this.inventLocationId = '',
    this.wMSLocationId = '',
    this.createdBy = '',
    DateTime? createdDateTime,
    this.modifiedBy = '',
    DateTime? modifiedDateTime,
  }) :  createdDateTime = createdDateTime ?? DateTimeHelper.minDateTime,
        modifiedDateTime = modifiedDateTime ?? DateTimeHelper.minDateTime;

  factory GoodsReceiptLineDto.fromJson(Map<String, dynamic> json) => GoodsReceiptLineDto(
    goodsReceiptLineId: json['goodsReceiptLineId'] as int? ?? 0,
    goodsReceiptHeaderId: json['goodsReceiptHeaderId'] as int? ?? 0,
    itemId: json['itemId'] as String? ?? '',
    lineNumber: json['lineNumber'] as int? ?? 0,
    itemName: json['itemName'] as String? ?? '',
    productType: ProductType.values[json['productType'] as int? ?? 0],
    remainPurchPhysical: json['remainPurchPhysical'] as double? ?? 0,
    receiveNow: json['receiveNow'] as double? ?? 0,
    purchQty: json['purchQty'] as double? ?? 0,
    purchUnit: json['purchUnit'] as String? ?? '',
    purchPrice: json['purchPrice'] as double? ?? 0,
    lineAmount: json['lineAmount'] as double? ?? 0,
    inventLocationId: json['inventLocationId'] as String? ?? '',
    wMSLocationId: json['wmsLocationId'] as String? ?? '',
    createdBy: json['createdBy'] as String? ?? '',
    createdDateTime: DateTime.tryParse(json['createdDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    modifiedBy: json['modifiedBy'] as String? ?? '',
    modifiedDateTime: DateTime.tryParse(json['modifiedDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
  );

  Map<String, dynamic> toJson() => {
    if (goodsReceiptLineId > 0) 'goodsReceiptLineId': goodsReceiptLineId,
    if (goodsReceiptHeaderId > 0) 'goodsReceiptHeaderId': goodsReceiptHeaderId,
    if (itemId.isNotEmpty) 'itemId': itemId,
    if (lineNumber > 0) 'lineNumber': lineNumber,
    if (itemName.isNotEmpty) 'itemName': itemName,
    if (productType != ProductType.none) 'productType': productType.index,
    if (remainPurchPhysical > 0) 'remainPurchPhysical': remainPurchPhysical,
    if (receiveNow > 0) 'receiveNow': receiveNow,
    if (purchQty > 0) 'purchQty': purchQty,
    if (purchUnit.isNotEmpty) 'purchUnit': purchUnit,
    if (purchPrice > 0) 'purchPrice': purchPrice,
    if (lineAmount > 0) 'lineAmount': lineAmount,
    if (inventLocationId.isNotEmpty) 'inventLocationId': inventLocationId,
    if (wMSLocationId.isNotEmpty) 'wmsLocationId': wMSLocationId,
    if (createdBy.isNotEmpty) 'createdBy': createdBy,
    if (createdDateTime.isAfter(DateTimeHelper.minDateTime)) 'createdDateTime': createdDateTime.toIso8601String(),
    if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
    if (modifiedDateTime.isAfter(DateTimeHelper.minDateTime)) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
  };

  bool compare(GoodsReceiptLineDto other) => goodsReceiptLineId == other.goodsReceiptLineId &&
    goodsReceiptHeaderId == other.goodsReceiptHeaderId &&
    itemId == other.itemId &&
    lineNumber == other.lineNumber &&
    itemName == other.itemName &&
    productType == other.productType &&
    remainPurchPhysical == other.remainPurchPhysical &&
    receiveNow == other.receiveNow &&
    purchQty == other.purchQty &&
    purchUnit == other.purchUnit &&
    purchPrice == other.purchPrice &&
    lineAmount == other.lineAmount &&
    inventLocationId == other.inventLocationId &&
    wMSLocationId == other.wMSLocationId;
}