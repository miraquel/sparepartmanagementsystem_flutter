
import '../Helper/date_time_helper.dart';
import 'base_model_dto.dart';

class GoodsReceiptHeaderDto extends BaseModelDto
{
  final int goodsReceiptHeaderId;
  final String packingSlipId;
  final String purchId;
  final String purchName;
  final String orderAccount;
  final String invoiceAccount;
  final String purchStatus;
  final DateTime submittedDate;
  final String submittedBy;

  GoodsReceiptHeaderDto({
    this.goodsReceiptHeaderId = 0,
    this.packingSlipId = '',
    this.purchId = '',
    this.purchName = '',
    this.orderAccount = '',
    this.invoiceAccount = '',
    this.purchStatus = '',
    DateTime? submittedDate,
    this.submittedBy = '',
    super.createdBy = '',
    DateTime? createdDateTime,
    super.modifiedBy = '',
    DateTime? modifiedDateTime,
  }) : submittedDate = submittedDate ?? DateTimeHelper.minDateTime, super(createdDateTime: createdDateTime ?? DateTimeHelper.minDateTime, modifiedDateTime: modifiedDateTime ?? DateTimeHelper.minDateTime);

  factory GoodsReceiptHeaderDto.fromJson(Map<String, dynamic> json) => GoodsReceiptHeaderDto(
    goodsReceiptHeaderId: json['goodsReceiptHeaderId'] as int? ?? 0,
    packingSlipId: json['packingSlipId'] as String? ?? '',
    purchId: json['purchId'] as String? ?? '',
    purchName: json['purchName'] as String? ?? '',
    orderAccount: json['orderAccount'] as String? ?? '',
    invoiceAccount: json['invoiceAccount'] as String? ?? '',
    purchStatus: json['purchStatus'] as String? ?? '',
    submittedDate: DateTime.tryParse(json['submittedDate'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    submittedBy: json['submittedBy'] as String? ?? '',
    createdBy: json['createdBy'] as String? ?? '',
    createdDateTime: DateTime.tryParse(json['createdDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
    modifiedBy: json['modifiedBy'] as String? ?? '',
    modifiedDateTime: DateTime.tryParse(json['modifiedDateTime'] as String? ?? '') ?? DateTimeHelper.minDateTime,
  );

  @override
  Map<String, dynamic> toJson() => {
    if (goodsReceiptHeaderId > 0) 'goodsReceiptHeaderId': goodsReceiptHeaderId,
    if (packingSlipId.isNotEmpty) 'packingSlipId': packingSlipId,
    if (purchId.isNotEmpty) 'purchId': purchId,
    if (purchName.isNotEmpty) 'purchName': purchName,
    if (orderAccount.isNotEmpty) 'orderAccount': orderAccount,
    if (invoiceAccount.isNotEmpty) 'invoiceAccount': invoiceAccount,
    if (purchStatus.isNotEmpty) 'purchStatus': purchStatus,
    if (submittedDate.isAfter(DateTimeHelper.minDateTime)) 'submittedDate': submittedDate.toIso8601String(),
    if (submittedBy.isNotEmpty) 'submittedBy': submittedBy,
    if (createdBy.isNotEmpty) 'createdBy': createdBy,
    if (createdDateTime.isAfter(DateTimeHelper.minDateTime)) 'createdDateTime': createdDateTime.toIso8601String(),
    if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
    if (modifiedDateTime.isAfter(DateTimeHelper.minDateTime)) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
  };
}