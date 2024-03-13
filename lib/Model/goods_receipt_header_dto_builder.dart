import 'goods_receipt_header_dto.dart';
import 'goods_receipt_line_dto_builder.dart';

class GoodsReceiptHeaderDtoBuilder {
  int _goodsReceiptHeaderId = 0;
  String _packingSlipId = '';
  String _purchId = '';
  String _purchName = '';
  String _orderAccount = '';
  String _invoiceAccount = '';
  String _purchStatus = '';
  bool? _isSubmitted;
  DateTime _submittedDate = DateTime.now();
  String _submittedBy = '';
  List<GoodsReceiptLineDtoBuilder> _goodsReceiptLines = <GoodsReceiptLineDtoBuilder>[];

  GoodsReceiptHeaderDtoBuilder();

  int get goodsReceiptHeaderId => _goodsReceiptHeaderId;
  String get packingSlipId => _packingSlipId;
  String get purchId => _purchId;
  String get purchName => _purchName;
  String get orderAccount => _orderAccount;
  String get invoiceAccount => _invoiceAccount;
  String get purchStatus => _purchStatus;
  bool? get isSubmitted => _isSubmitted;
  DateTime get submittedDate => _submittedDate;
  String get submittedBy => _submittedBy;
  List<GoodsReceiptLineDtoBuilder> get goodsReceiptLines => _goodsReceiptLines;

  factory GoodsReceiptHeaderDtoBuilder.fromDto(GoodsReceiptHeaderDto goodsReceiptHeaderDto) {
    return GoodsReceiptHeaderDtoBuilder()
      .setGoodsReceiptHeaderId(goodsReceiptHeaderDto.goodsReceiptHeaderId)
      .setPackingSlipId(goodsReceiptHeaderDto.packingSlipId)
      .setPurchId(goodsReceiptHeaderDto.purchId)
      .setPurchName(goodsReceiptHeaderDto.purchName)
      .setOrderAccount(goodsReceiptHeaderDto.orderAccount)
      .setInvoiceAccount(goodsReceiptHeaderDto.invoiceAccount)
      .setPurchStatus(goodsReceiptHeaderDto.purchStatus)
      .setIsSubmitted(goodsReceiptHeaderDto.isSubmitted)
      .setSubmittedDate(goodsReceiptHeaderDto.submittedDate)
      .setSubmittedBy(goodsReceiptHeaderDto.submittedBy)
      .setGoodsReceiptLines(goodsReceiptHeaderDto.goodsReceiptLines.map((e) => GoodsReceiptLineDtoBuilder.fromDto(e)).toList());
  }

  GoodsReceiptHeaderDtoBuilder setGoodsReceiptHeaderId(int goodsReceiptHeaderId) {
    _goodsReceiptHeaderId = goodsReceiptHeaderId;
    return this;
  }

  GoodsReceiptHeaderDtoBuilder setPackingSlipId(String packingSlipId) {
    _packingSlipId = packingSlipId;
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

  GoodsReceiptHeaderDtoBuilder setGoodsReceiptLines(List<GoodsReceiptLineDtoBuilder> goodsReceiptLines) {
    _goodsReceiptLines = goodsReceiptLines;
    return this;
  }

  GoodsReceiptHeaderDto build() {
    return GoodsReceiptHeaderDto(
      goodsReceiptHeaderId: _goodsReceiptHeaderId,
      packingSlipId: packingSlipId,
      purchId: _purchId,
      purchName: _purchName,
      orderAccount: _orderAccount,
      invoiceAccount: _invoiceAccount,
      purchStatus: _purchStatus,
      isSubmitted: _isSubmitted,
      submittedDate: _submittedDate,
      submittedBy: _submittedBy,
      goodsReceiptLines: goodsReceiptLines.map((e) => e.build()).toList(),
    );
  }
}