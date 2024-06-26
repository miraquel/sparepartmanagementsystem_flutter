import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_line_dto.dart';

class GoodsReceiptHeaderDto
{
  final int goodsReceiptHeaderId;
  final String packingSlipId;
  final DateTime transDate;
  final String description;
  final String purchId;
  final String purchName;
  final String orderAccount;
  final String invoiceAccount;
  final String purchStatus;
  final bool? isSubmitted;
  final DateTime submittedDate;
  final String submittedBy;
  final String createdBy;
  final DateTime createdDateTime;
  final String modifiedBy;
  final DateTime modifiedDateTime;
  final List<GoodsReceiptLineDto> goodsReceiptLines;

  GoodsReceiptHeaderDto({
    this.goodsReceiptHeaderId = 0,
    this.packingSlipId = '',
    DateTime? transDate,
    this.description = '',
    this.purchId = '',
    this.purchName = '',
    this.orderAccount = '',
    this.invoiceAccount = '',
    this.purchStatus = '',
    this.isSubmitted,
    DateTime? submittedDate,
    this.submittedBy = '',
    this.createdBy = '',
    DateTime? createdDateTime,
    this.modifiedBy = '',
    DateTime? modifiedDateTime,
    List<GoodsReceiptLineDto>? goodsReceiptLines,
  }) :  transDate = transDate ?? DateTimeHelper.minDateTime,
        submittedDate = submittedDate ?? DateTimeHelper.minDateTime,
        createdDateTime = createdDateTime ?? DateTimeHelper.minDateTime,
        modifiedDateTime = modifiedDateTime ?? DateTimeHelper.minDateTime,
        goodsReceiptLines = goodsReceiptLines ?? <GoodsReceiptLineDto>[];

  factory GoodsReceiptHeaderDto.fromJson(Map<String, dynamic> json) => GoodsReceiptHeaderDto(
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
    goodsReceiptLines: json['goodsReceiptLines']?.map<GoodsReceiptLineDto>((e) => GoodsReceiptLineDto.fromJson(e as Map<String, dynamic>)).toList(),
    createdBy: json['createdBy'] as String? ?? '',
    createdDateTime: DateTime.tryParse(json['createdDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    modifiedBy: json['modifiedBy'] as String? ?? '',
    modifiedDateTime: DateTime.tryParse(json['modifiedDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
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
    if (goodsReceiptLines.isNotEmpty) 'goodsReceiptLines': goodsReceiptLines.map((e) => e.toJson()).toList(),
    if (createdBy.isNotEmpty) 'createdBy': createdBy,
    if (createdDateTime.isAfter(DateTimeHelper.minDateTime)) 'createdDateTime': createdDateTime.toIso8601String(),
    if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
    if (modifiedDateTime.isAfter(DateTimeHelper.minDateTime)) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
  };

  bool isDefault() => goodsReceiptHeaderId == 0 &&
      packingSlipId.isEmpty &&
      transDate.isAtSameMomentAs(DateTimeHelper.minDateTime) &&
      description.isEmpty &&
      purchId.isEmpty &&
      purchName.isEmpty &&
      orderAccount.isEmpty &&
      invoiceAccount.isEmpty &&
      purchStatus.isEmpty &&
      isSubmitted == null &&
      submittedDate.isAtSameMomentAs(DateTimeHelper.minDateTime) &&
      submittedBy.isEmpty &&
      createdBy.isEmpty &&
      createdDateTime.isAtSameMomentAs(DateTimeHelper.minDateTime) &&
      modifiedBy.isEmpty &&
      modifiedDateTime.isAtSameMomentAs(DateTimeHelper.minDateTime);

  bool compare(GoodsReceiptHeaderDto other) => goodsReceiptHeaderId == other.goodsReceiptHeaderId &&
      packingSlipId == other.packingSlipId &&
      transDate.isAtSameMomentAs(other.transDate) &&
      description == other.description &&
      purchId == other.purchId &&
      purchName == other.purchName &&
      orderAccount == other.orderAccount &&
      invoiceAccount == other.invoiceAccount &&
      purchStatus == other.purchStatus &&
      isSubmitted == other.isSubmitted &&
      submittedDate.isAtSameMomentAs(other.submittedDate) &&
      submittedBy == other.submittedBy &&
      goodsReceiptLines.length == other.goodsReceiptLines.length &&
      goodsReceiptLines.every((e) => other.goodsReceiptLines.any((x) => e.compare(x)));
}