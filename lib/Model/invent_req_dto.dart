import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';

class InventReqDto {
  final String itemId;
  final String productName;
  final DateTime requiredDate;
  final double qty;
  final int unitOfMeasure;
  final String currency;
  final double costPrice;
  final double costAmount;
  final String inventSiteId;
  final String inventLocationId;
  final String wmsLocationId;
  final int agswoRecId;
  final String createdBy;
  final DateTime createdDateTime;
  final String modifiedBy;
  final DateTime modifiedDateTime;
  final int recId;

  InventReqDto({
    this.itemId = '',
    this.productName = '',
    DateTime? requiredDate,
    this.qty = 0,
    this.unitOfMeasure = 0,
    this.currency = '',
    this.costPrice = 0,
    this.costAmount = 0,
    this.inventSiteId = '',
    this.inventLocationId = '',
    this.wmsLocationId = '',
    this.agswoRecId = 0,
    this.createdBy = '',
    DateTime? createdDateTime,
    this.modifiedBy = '',
    DateTime? modifiedDateTime,
    this.recId = 0,
  })  : requiredDate = requiredDate ?? DateTimeHelper.minDateTime,
        createdDateTime = createdDateTime ?? DateTimeHelper.minDateTime,
        modifiedDateTime = modifiedDateTime ?? DateTimeHelper.minDateTime;

  factory InventReqDto.fromJson(Map<String, dynamic> json) {
    return InventReqDto(
      itemId: json['itemId'] ?? '',
      productName: json['productName'] ?? '',
      requiredDate: DateTime.tryParse(json['requiredDate'] as String? ?? '') ?? DateTimeHelper.minDateTime,
      qty: json['qty'] as double? ?? 0,
      unitOfMeasure: json['unitOfMeasure'] ?? 0,
      currency: json['currency'] ?? '',
      costPrice: json['costPrice'] as double? ?? 0,
      costAmount: json['costAmount'] as double? ?? 0,
      inventSiteId: json['inventSiteId'] ?? '',
      inventLocationId: json['inventLocationId'] ?? '',
      wmsLocationId: json['wmsLocationId'] ?? '',
      agswoRecId: json['agsWoRecId'] ?? 0,
      createdBy: json['createdBy'] ?? '',
      createdDateTime: DateTime.tryParse(json['createdDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
      modifiedBy: json['modifiedBy'] ?? '',
      modifiedDateTime: DateTime.tryParse(json['modifiedDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
      recId: json['recId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (itemId.isNotEmpty) 'itemId': itemId,
      if (productName.isNotEmpty) 'productName': productName,
      if (requiredDate.isAfter(DateTimeHelper.minDateTime)) 'requiredDate': requiredDate.toIso8601String(),
      if (qty != 0) 'qty': qty,
      if (unitOfMeasure != 0) 'unitOfMeasure': unitOfMeasure,
      if (currency.isNotEmpty) 'currency': currency,
      if (costPrice != 0) 'costPrice': costPrice,
      if (costAmount != 0) 'costAmount': costAmount,
      if (inventSiteId.isNotEmpty) 'inventSiteId': inventSiteId,
      if (inventLocationId.isNotEmpty) 'inventLocationId': inventLocationId,
      if (wmsLocationId.isNotEmpty) 'wmsLocationId': wmsLocationId,
      if (agswoRecId != 0) 'agsWoRecId': agswoRecId,
      if (createdBy.isNotEmpty) 'createdBy': createdBy,
      if (createdDateTime.isAfter(DateTimeHelper.minDateTime)) 'createdDateTime': createdDateTime.toIso8601String(),
      if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
      if (modifiedDateTime.isAfter(DateTimeHelper.minDateTime)) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
      if (recId != 0) 'recId': recId,
    };
  }
}