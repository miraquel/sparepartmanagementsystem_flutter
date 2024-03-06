import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/base_model_dto.dart';

class GoodsReceiptLineDto extends BaseModelDto
{
  final int goodsReceiptLineId;
  final int goodsReceiptHeaderId;
  final String itemId;
  final int quantity;
  final double price;
  final double amount;

  GoodsReceiptLineDto({
    this.goodsReceiptLineId = 0,
    this.goodsReceiptHeaderId = 0,
    this.itemId = '',
    this.quantity = 0,
    this.price = 0,
    this.amount = 0,
    super.createdBy = '',
    DateTime? createdDateTime,
    super.modifiedBy = '',
    DateTime? modifiedDateTime,
  }) : super(createdDateTime: createdDateTime ?? DateTimeHelper.minDateTime, modifiedDateTime: modifiedDateTime ?? DateTimeHelper.minDateTime);

  factory GoodsReceiptLineDto.fromJson(Map<String, dynamic> json) => GoodsReceiptLineDto(
    goodsReceiptLineId: json['goodsReceiptLineId'] as int? ?? 0,
    goodsReceiptHeaderId: json['goodsReceiptHeaderId'] as int? ?? 0,
    itemId: json['itemId'] as String? ?? '',
    quantity: json['quantity'] as int? ?? 0,
    price: json['price'] as double? ?? 0,
    amount: json['amount'] as double? ?? 0,
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
    if (quantity > 0) 'quantity': quantity,
    if (price > 0) 'price': price,
    if (amount > 0) 'amount': amount,
    if (createdBy.isNotEmpty) 'createdBy': createdBy,
    if (createdDateTime.isAfter(DateTimeHelper.minDateTime)) 'createdDateTime': createdDateTime.toIso8601String(),
    if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
    if (modifiedDateTime.isAfter(DateTimeHelper.minDateTime)) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
  };
}