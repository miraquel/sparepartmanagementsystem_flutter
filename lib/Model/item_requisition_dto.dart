import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';

class ItemRequisitionDto {
  final int itemRequisitionId;
  final int workOrderLineId;
  final String itemId;
  final String itemName;
  final DateTime requiredDate;
  final double quantity;
  final double requestQuantity;
  final String inventLocationId;
  final String wMSLocationId;
  final String createdBy;
  final DateTime createdDateTime;
  final String modifiedBy;
  final DateTime modifiedDateTime;

  ItemRequisitionDto({
    this.itemRequisitionId = 0,
    this.workOrderLineId = 0,
    this.itemId = '',
    this.itemName = '',
    DateTime? requiredDate,
    this.quantity = 0,
    this.requestQuantity = 0,
    this.inventLocationId = '',
    this.wMSLocationId = '',
    this.createdBy = '',
    DateTime? createdDateTime,
    this.modifiedBy = '',
    DateTime? modifiedDateTime,
  }) :  requiredDate = requiredDate ?? DateTimeHelper.minDateTime,
        createdDateTime = createdDateTime ?? DateTimeHelper.minDateTime,
        modifiedDateTime = modifiedDateTime ?? DateTimeHelper.minDateTime;

  factory ItemRequisitionDto.fromJson(Map<String, dynamic> json) => ItemRequisitionDto(
    itemRequisitionId: json['itemRequisitionId'] as int? ?? 0,
    workOrderLineId: json['workOrderLineId'] as int? ?? 0,
    itemId: json['itemId'] as String? ?? '',
    itemName: json['itemName'] as String? ?? '',
    requiredDate: DateTime.tryParse(json['requiredDate'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    quantity: json['quantity'] as double? ?? 0,
    requestQuantity: json['requestQuantity'] as double? ?? 0,
    inventLocationId: json['inventLocationId'] as String? ?? '',
    wMSLocationId: json['wmsLocationId'] as String? ?? '',
    createdBy: json['createdBy'] as String? ?? '',
    createdDateTime: DateTime.tryParse(json['createdDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    modifiedBy: json['modifiedBy'] as String? ?? '',
    modifiedDateTime: DateTime.tryParse(json['modifiedDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
  );

  Map<String, dynamic> toJson() {
    return {
      if (itemRequisitionId != 0) 'itemRequisitionId': itemRequisitionId,
      if (workOrderLineId != 0) 'workOrderLineId': workOrderLineId,
      if (itemId.isNotEmpty) 'itemId': itemId,
      if (itemName.isNotEmpty) 'itemName': itemName,
      if (requiredDate != DateTimeHelper.minDateTime) 'requiredDate': requiredDate.toIso8601String(),
      if (quantity != 0) 'quantity': quantity.toString(),
      if (requestQuantity != 0) 'requestQuantity': requestQuantity.toString(),
      if (inventLocationId.isNotEmpty) 'inventLocationId': inventLocationId,
      if (wMSLocationId.isNotEmpty) 'wmsLocationId': wMSLocationId,
      if (createdBy.isNotEmpty) 'createdBy': createdBy,
      if (createdDateTime != DateTimeHelper.minDateTime) 'createdDateTime': createdDateTime.toIso8601String(),
      if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
      if (modifiedDateTime != DateTimeHelper.minDateTime) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
    };
  }

}