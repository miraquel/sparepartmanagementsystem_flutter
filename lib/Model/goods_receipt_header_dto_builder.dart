import 'package:sparepartmanagementsystem_flutter/Model/purch_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/goods_receipt_line_dto_builder.dart';
import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';

class GoodsReceiptHeaderDtoBuilder {
  int _goodsReceiptHeaderId = 0;
  String _packingSlipId = '';
  DateTime _transDate = DateTimeHelper.minDateTime;
  String _description = '';
  String _purchId = '';
  String _purchName = '';
  String _orderAccount = '';
  String _invoiceAccount = '';
  String _purchStatus = '';
  bool? _isSubmitted;
  DateTime _submittedDate = DateTimeHelper.minDateTime;
  String _submittedBy = '';
  String _createdBy = '';
  DateTime _createdDateTime = DateTimeHelper.minDateTime;
  String _modifiedBy = '';
  DateTime _modifiedDateTime = DateTimeHelper.minDateTime;
  List<GoodsReceiptLineDtoBuilder> _goodsReceiptLines = <GoodsReceiptLineDtoBuilder>[];

  GoodsReceiptHeaderDtoBuilder();

  int                               get goodsReceiptHeaderId => _goodsReceiptHeaderId;
  String                            get packingSlipId => _packingSlipId;
  DateTime                          get transDate => _transDate;
  String                            get description => _description;
  String                            get purchId => _purchId;
  String                            get purchName => _purchName;
  String                            get orderAccount => _orderAccount;
  String                            get invoiceAccount => _invoiceAccount;
  String                            get purchStatus => _purchStatus;
  bool?                             get isSubmitted => _isSubmitted;
  DateTime                          get submittedDate => _submittedDate;
  String                            get submittedBy => _submittedBy;
  String                            get createdBy => _createdBy;
  DateTime                          get createdDateTime => _createdDateTime;
  String                            get modifiedBy => _modifiedBy;
  DateTime                          get modifiedDateTime => _modifiedDateTime;
  List<GoodsReceiptLineDtoBuilder>  get goodsReceiptLines => _goodsReceiptLines;

  factory GoodsReceiptHeaderDtoBuilder.fromDto(GoodsReceiptHeaderDto goodsReceiptHeaderDto) {
    return GoodsReceiptHeaderDtoBuilder()
      .setGoodsReceiptHeaderId(goodsReceiptHeaderDto.goodsReceiptHeaderId)
      .setPackingSlipId(goodsReceiptHeaderDto.packingSlipId)
      .setTransDate(goodsReceiptHeaderDto.transDate)
      .setDescription(goodsReceiptHeaderDto.description)
      .setPurchId(goodsReceiptHeaderDto.purchId)
      .setPurchName(goodsReceiptHeaderDto.purchName)
      .setOrderAccount(goodsReceiptHeaderDto.orderAccount)
      .setInvoiceAccount(goodsReceiptHeaderDto.invoiceAccount)
      .setPurchStatus(goodsReceiptHeaderDto.purchStatus)
      .setIsSubmitted(goodsReceiptHeaderDto.isSubmitted)
      .setSubmittedDate(goodsReceiptHeaderDto.submittedDate)
      .setSubmittedBy(goodsReceiptHeaderDto.submittedBy)
      .setCreatedBy(goodsReceiptHeaderDto.createdBy)
      .setCreatedDateTime(goodsReceiptHeaderDto.createdDateTime)
      .setModifiedBy(goodsReceiptHeaderDto.modifiedBy)
      .setModifiedDateTime(goodsReceiptHeaderDto.modifiedDateTime)
      .setGoodsReceiptLines(goodsReceiptHeaderDto.goodsReceiptLines.map((e) => GoodsReceiptLineDtoBuilder.fromDto(e)).toList());
  }

  GoodsReceiptHeaderDtoBuilder setFromPurchTableDto(PurchTableDto purchTableDto) {
    return this
        .._purchId = purchTableDto.purchId
        .._purchName = purchTableDto.purchName
        .._orderAccount = purchTableDto.orderAccount
        .._invoiceAccount = purchTableDto.invoiceAccount
        .._purchStatus = purchTableDto.purchStatus;
  }

  bool isDefault() {
    return _goodsReceiptHeaderId == 0 &&
        _packingSlipId.isEmpty &&
        _transDate == DateTimeHelper.minDateTime &&
        _description.isEmpty &&
        _purchId.isEmpty &&
        _purchName.isEmpty &&
        _orderAccount.isEmpty &&
        _invoiceAccount.isEmpty &&
        _purchStatus.isEmpty &&
        _isSubmitted == null &&
        _submittedDate == DateTimeHelper.minDateTime &&
        _submittedBy.isEmpty &&
        _createdBy.isEmpty &&
        _createdDateTime == DateTimeHelper.minDateTime &&
        _modifiedBy.isEmpty &&
        _modifiedDateTime == DateTimeHelper.minDateTime &&
        _goodsReceiptLines.isEmpty;
  }

  GoodsReceiptHeaderDtoBuilder addGoodsReceiptLine(PurchLineDto purchLineDto) {
    var goodsReceiptLineDtoBuilder = GoodsReceiptLineDtoBuilder.fromPurchLineDto(purchLineDto);
    goodsReceiptLineDtoBuilder.setGoodsReceiptHeaderId(goodsReceiptHeaderId);
    _goodsReceiptLines.add(goodsReceiptLineDtoBuilder);
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setGoodsReceiptHeaderId(int goodsReceiptHeaderId) {
    _goodsReceiptHeaderId = goodsReceiptHeaderId;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setPackingSlipId(String packingSlipId) {
    _packingSlipId = packingSlipId;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setTransDate(DateTime transDate) {
    _transDate = transDate;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setDescription(String description) {
    _description = description;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setPurchId(String purchId) {
    _purchId = purchId;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setPurchName(String purchName) {
    _purchName = purchName;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setOrderAccount(String orderAccount) {
    _orderAccount = orderAccount;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setInvoiceAccount(String invoiceAccount) {
    _invoiceAccount = invoiceAccount;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setPurchStatus(String purchStatus) {
    _purchStatus = purchStatus;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setIsSubmitted(bool? isSubmitted) {
    _isSubmitted = isSubmitted;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setSubmittedDate(DateTime submittedDate) {
    _submittedDate = submittedDate;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setSubmittedBy(String submittedBy) {
    _submittedBy = submittedBy;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setCreatedBy(String createdBy) {
    _createdBy = createdBy;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setCreatedDateTime(DateTime createdDateTime) {
    _createdDateTime = createdDateTime;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setModifiedBy(String modifiedBy) {
    _modifiedBy = modifiedBy;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setModifiedDateTime(DateTime modifiedDateTime) {
    _modifiedDateTime = modifiedDateTime;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setGoodsReceiptLines(List<GoodsReceiptLineDtoBuilder> goodsReceiptLines) {
    _goodsReceiptLines = goodsReceiptLines;
    return this;
  }

  bool isAtLeastOneGoodsReceiptLineSelected() {
    return _goodsReceiptLines.any((element) => element.isSelected);
  }

  bool isNoGoodsReceiptLineSelected() {
    return _goodsReceiptLines.every((element) => !element.isSelected);
  }

  bool isAllGoodsReceiptLinesSelected() {
    return _goodsReceiptLines.every((element) => element.isSelected);
  }

  void selectAllGoodsReceiptLines() {
    for (var element in _goodsReceiptLines) {
      element.setIsSelected(true);
    }
  }

  void deselectAllGoodsReceiptLines() {
    for (var element in _goodsReceiptLines) {
      element.setIsSelected(false);
    }
  }

  void deleteSelectedGoodsReceiptLines() {
    _goodsReceiptLines.removeWhere((element) => element.isSelected);
  }

  bool compareWithPurchTable(PurchTableDto purchTableDto) {
    return _purchId == purchTableDto.purchId &&
        _purchName == purchTableDto.purchName &&
        _orderAccount == purchTableDto.orderAccount &&
        _invoiceAccount == purchTableDto.invoiceAccount &&
        _purchStatus == purchTableDto.purchStatus;
  }

  GoodsReceiptHeaderDtoBuilder updateFromPurchTable(PurchTableDto purchTableDto) {
    _purchId = purchTableDto.purchId;
    _purchName = purchTableDto.purchName;
    _orderAccount = purchTableDto.orderAccount;
    _invoiceAccount = purchTableDto.invoiceAccount;
    _purchStatus = purchTableDto.purchStatus;
    return this;
  }

  GoodsReceiptHeaderDto build() {
    return GoodsReceiptHeaderDto(
      goodsReceiptHeaderId: _goodsReceiptHeaderId,
      packingSlipId: packingSlipId,
      transDate: _transDate,
      description: _description,
      purchId: _purchId,
      purchName: _purchName,
      orderAccount: _orderAccount,
      invoiceAccount: _invoiceAccount,
      purchStatus: _purchStatus,
      isSubmitted: _isSubmitted,
      submittedDate: _submittedDate,
      submittedBy: _submittedBy,
      createdBy: _createdBy,
      createdDateTime: _createdDateTime,
      modifiedBy: _modifiedBy,
      modifiedDateTime: _modifiedDateTime,
      goodsReceiptLines: goodsReceiptLines.map((e) => e.build()).toList(),
    );
  }
}