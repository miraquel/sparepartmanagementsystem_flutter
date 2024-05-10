import 'package:decimal/decimal.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/base_model_dto.dart';

class ItemRequisitionDto extends BaseModelDto {
  final int itemRequisitionId;
  final int workOrderLineId;
  final String itemId;
  final String itemName;
  final DateTime requiredDate;
  final Decimal quantity;
  final Decimal requestQuantity;
  final String inventLocationId;
  final String wMSLocationId;

  ItemRequisitionDto({
    this.itemRequisitionId = 0,
    this.workOrderLineId = 0,
    this.itemId = '',
    this.itemName = '',
    DateTime? requiredDate,
    Decimal? quantity,
    Decimal? requestQuantity,
    this.inventLocationId = '',
    this.wMSLocationId = '',
    super.createdBy = '',
    DateTime? createdDateTime,
    super.modifiedBy = '',
    DateTime? modifiedDateTime,
  }) : requiredDate = requiredDate ?? DateTimeHelper.minDateTime, quantity = quantity ?? Decimal.zero, requestQuantity = requestQuantity ?? Decimal.zero, super(createdDateTime: createdDateTime ?? DateTimeHelper.minDateTime, modifiedDateTime: modifiedDateTime ?? DateTimeHelper.minDateTime);

  factory ItemRequisitionDto.fromJson(Map<String, dynamic> json) => ItemRequisitionDto(
    itemRequisitionId: json['itemRequisitionId'] as int? ?? 0,
    workOrderLineId: json['workOrderLineId'] as int? ?? 0,
    itemId: json['itemId'] as String? ?? '',
    itemName: json['itemName'] as String? ?? '',
    requiredDate: DateTime.tryParse(json['requiredDate'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    quantity: Decimal.tryParse(json['quantity'] as String? ?? '0') ?? Decimal.zero,
    requestQuantity: Decimal.tryParse(json['requestQuantity'] as String? ?? '0') ?? Decimal.zero,
    inventLocationId: json['inventLocationId'] as String? ?? '',
    wMSLocationId: json['wmsLocationId'] as String? ?? '',
    createdBy: json['createdBy'] as String? ?? '',
    createdDateTime: DateTime.tryParse(json['createdDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    modifiedBy: json['modifiedBy'] as String? ?? '',
    modifiedDateTime: DateTime.tryParse(json['modifiedDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      if (itemRequisitionId != 0) 'itemRequisitionId': itemRequisitionId,
      if (workOrderLineId != 0) 'workOrderLineId': workOrderLineId,
      if (itemId.isNotEmpty) 'itemId': itemId,
      if (itemName.isNotEmpty) 'itemName': itemName,
      if (requiredDate != DateTimeHelper.minDateTime) 'requiredDate': requiredDate.toIso8601String(),
      if (quantity != Decimal.zero) 'quantity': quantity.toString(),
      if (requestQuantity != Decimal.zero) 'requestQuantity': requestQuantity.toString(),
      if (inventLocationId.isNotEmpty) 'inventLocationId': inventLocationId,
      if (wMSLocationId.isNotEmpty) 'wmsLocationId': wMSLocationId,
      if (createdBy.isNotEmpty) 'createdBy': createdBy,
      if (createdDateTime != DateTimeHelper.minDateTime) 'createdDateTime': createdDateTime.toIso8601String(),
      if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
      if (modifiedDateTime != DateTimeHelper.minDateTime) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
    };
  }

}