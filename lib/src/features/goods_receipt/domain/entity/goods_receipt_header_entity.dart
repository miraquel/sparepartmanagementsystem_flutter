import 'package:equatable/equatable.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/domain/entity/goods_receipt_line_entity.dart';

class GoodsReceiptHeaderEntity extends Equatable {
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
  final List<GoodsReceiptLineEntity> goodsReceiptLines;

  GoodsReceiptHeaderEntity({
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
    List<GoodsReceiptLineEntity>? goodsReceiptLines,
  }) :  transDate = transDate ?? DateTimeHelper.minDateTime,
        submittedDate = submittedDate ?? DateTimeHelper.minDateTime,
        createdDateTime = createdDateTime ?? DateTimeHelper.minDateTime,
        modifiedDateTime = modifiedDateTime ?? DateTimeHelper.minDateTime,
        goodsReceiptLines = goodsReceiptLines ?? <GoodsReceiptLineEntity>[];

  @override
  List<Object?> get props {
    return [
      goodsReceiptHeaderId,
      packingSlipId,
      transDate,
      description,
      purchId,
      purchName,
      orderAccount,
      invoiceAccount,
      purchStatus,
      isSubmitted,
      submittedDate,
      submittedBy,
      createdBy,
      createdDateTime,
      modifiedBy,
      modifiedDateTime,
      goodsReceiptLines
    ];
  }

}