import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/base_model_dto.dart';

class GoodsReceiptLineDto extends BaseModelDto
{
  final int goodsReceiptLineId;
  final int goodsReceiptHeaderId;
  final String itemId;
  final int lineNumber;
  final String itemName;
  final double purchQty;
  final String purchUnit;
  final double purchPrice;
  final double lineAmount;
  final String inventLocationId;
  final String wMSLocationId;

  GoodsReceiptLineDto({
    this.goodsReceiptLineId = 0,
    this.goodsReceiptHeaderId = 0,
    this.itemId = '',
    this.lineNumber = 0,
    this.itemName = '',
    this.purchQty = 0,
    this.purchUnit = '',
    this.purchPrice = 0,
    this.lineAmount = 0,
    this.inventLocationId = '',
    this.wMSLocationId = '',
    super.createdBy = '',
    DateTime? createdDateTime,
    super.modifiedBy = '',
    DateTime? modifiedDateTime,
  }) : super(createdDateTime: createdDateTime ?? DateTimeHelper.minDateTime, modifiedDateTime: modifiedDateTime ?? DateTimeHelper.minDateTime);

  factory GoodsReceiptLineDto.fromJson(Map<String, dynamic> json) => GoodsReceiptLineDto(
    goodsReceiptLineId: json['goodsReceiptLineId'] as int? ?? 0,
    goodsReceiptHeaderId: json['goodsReceiptHeaderId'] as int? ?? 0,
    itemId: json['itemId'] as String? ?? '',
    lineNumber: json['lineNumber'] as int? ?? 0,
    itemName: json['itemName'] as String? ?? '',
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

  @override
  Map<String, dynamic> toJson() => {
    if (goodsReceiptLineId > 0) 'goodsReceiptLineId': goodsReceiptLineId,
    if (goodsReceiptHeaderId > 0) 'goodsReceiptHeaderId': goodsReceiptHeaderId,
    if (itemId.isNotEmpty) 'itemId': itemId,
    if (lineNumber > 0) 'lineNumber': lineNumber,
    if (itemName.isNotEmpty) 'itemName': itemName,
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
}