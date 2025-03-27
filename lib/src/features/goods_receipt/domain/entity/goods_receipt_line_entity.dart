import 'package:equatable/equatable.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/product_type.dart';

class GoodsReceiptLineEntity extends Equatable {
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
  final String inventBatchId;
  final String trackingDimensionGroupName;
  final String createdBy;
  final DateTime createdDateTime;
  final String modifiedBy;
  final DateTime modifiedDateTime;

  GoodsReceiptLineEntity({
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
    this.inventBatchId = '',
    this.trackingDimensionGroupName = '',
    this.createdBy = '',
    DateTime? createdDateTime,
    this.modifiedBy = '',
    DateTime? modifiedDateTime,
  }) :  createdDateTime = createdDateTime ?? DateTimeHelper.minDateTime,
        modifiedDateTime = modifiedDateTime ?? DateTimeHelper.minDateTime;

  @override
  List<Object?> get props {
    return [
      goodsReceiptLineId,
      goodsReceiptHeaderId,
      itemId,
      lineNumber,
      itemName,
      productType,
      remainPurchPhysical,
      receiveNow,
      purchQty,
      purchUnit,
      purchPrice,
      lineAmount,
      inventLocationId,
      wMSLocationId,
      inventBatchId,
      trackingDimensionGroupName,
      createdBy,
      createdDateTime,
      modifiedBy,
      modifiedDateTime,
    ];
  }
}