import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/data/model/goods_receipt_line_model.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/domain/entity/goods_receipt_header_entity.dart';

class GoodsReceiptHeaderModel extends GoodsReceiptHeaderEntity {
  GoodsReceiptHeaderModel({
    super.goodsReceiptHeaderId,
    super.packingSlipId,
    super.transDate,
    super.description,
    super.purchId,
    super.purchName,
    super.orderAccount,
    super.invoiceAccount,
    super.purchStatus,
    super.isSubmitted,
    super.submittedDate,
    super.submittedBy,
    super.createdBy,
    super.createdDateTime,
    super.modifiedBy,
    super.modifiedDateTime,
    super.goodsReceiptLines,
  });

  factory GoodsReceiptHeaderModel.fromJson(Map<String, dynamic> json) => GoodsReceiptHeaderModel(
    goodsReceiptHeaderId: json['goodsReceiptHeaderId'] as int? ?? 0,
    packingSlipId: json['packingSlipId'] as String? ?? '',
    transDate: DateTime.tryParse(json['transDate'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    description: json['description'] as String? ?? '',
    purchId: json['purchId'] as String? ?? '',
    purchName: json['purchName'] as String? ?? '',
    orderAccount: json['orderAccount'] as String? ?? '',
    invoiceAccount: json['invoiceAccount'] as String? ?? '',
    purchStatus: json['purchStatus'] as String? ?? '',
    isSubmitted: json['isSubmitted'] as bool? ?? false,
    submittedDate: DateTime.tryParse(json['submittedDate'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    submittedBy: json['submittedBy'] as String? ?? '',
    createdBy: json['createdBy'] as String? ?? '',
    createdDateTime: DateTime.tryParse(json['createdDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    modifiedBy: json['modifiedBy'] as String? ?? '',
    modifiedDateTime: DateTime.tryParse(json['modifiedDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    goodsReceiptLines: json['goodsReceiptLines']?.map<GoodsReceiptLineModel>((e) => GoodsReceiptLineModel.fromJson(e as Map<String, dynamic>)).toList(),
  );

  Map<String, dynamic> toJson() => {
    if (goodsReceiptHeaderId > 0) 'goodsReceiptHeaderId': goodsReceiptHeaderId,
    if (packingSlipId.isNotEmpty) 'packingSlipId': packingSlipId,
    if (transDate.isAfter(DateTimeHelper.minDateTime)) 'transDate': transDate.toIso8601String(),
    if (description.isNotEmpty) 'description': description,
    if (purchId.isNotEmpty) 'purchId': purchId,
    if (purchName.isNotEmpty) 'purchName': purchName,
    if (orderAccount.isNotEmpty) 'orderAccount': orderAccount,
    if (invoiceAccount.isNotEmpty) 'invoiceAccount': invoiceAccount,
    if (purchStatus.isNotEmpty) 'purchStatus': purchStatus,
    if (isSubmitted != null) 'isSubmitted': isSubmitted,
    if (submittedDate.isAfter(DateTimeHelper.minDateTime)) 'submittedDate': submittedDate.toIso8601String(),
    if (submittedBy.isNotEmpty) 'submittedBy': submittedBy,
    if (createdBy.isNotEmpty) 'createdBy': createdBy,
    if (createdDateTime.isAfter(DateTimeHelper.minDateTime)) 'createdDateTime': createdDateTime.toIso8601String(),
    if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
    if (modifiedDateTime.isAfter(DateTimeHelper.minDateTime)) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
    if (goodsReceiptLines.isNotEmpty) 'goodsReceiptLines': goodsReceiptLines.map((e) => GoodsReceiptLineModel.fromEntity(e).toJson()).toList(),
  };

  factory GoodsReceiptHeaderModel.fromEntity(GoodsReceiptHeaderEntity entity) => GoodsReceiptHeaderModel(
    goodsReceiptHeaderId: entity.goodsReceiptHeaderId,
    packingSlipId: entity.packingSlipId,
    transDate: entity.transDate,
    description: entity.description,
    purchId: entity.purchId,
    purchName: entity.purchName,
    orderAccount: entity.orderAccount,
    invoiceAccount: entity.invoiceAccount,
    purchStatus: entity.purchStatus,
    isSubmitted: entity.isSubmitted,
    submittedDate: entity.submittedDate,
    submittedBy: entity.submittedBy,
    createdBy: entity.createdBy,
    createdDateTime: entity.createdDateTime,
    modifiedBy: entity.modifiedBy,
    modifiedDateTime: entity.modifiedDateTime,
  );
}