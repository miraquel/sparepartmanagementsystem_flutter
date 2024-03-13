import 'goods_receipt_line_dto.dart';

class GoodsReceiptLineDtoBuilder {
  int _goodsReceiptLineId = 0;
  int _goodsReceiptHeaderId = 0;
  String _itemId = '';
  int _lineNumber = 0;
  String _itemName = '';
  double _purchQty = 0;
  String _purchUnit = '';
  double _purchPrice = 0;
  double _lineAmount = 0;
  String _inventLocationId = '';
  String _wMSLocationId = '';

  GoodsReceiptLineDtoBuilder();

  int     get goodsReceiptLineId => _goodsReceiptLineId;
  int     get goodsReceiptHeaderId => _goodsReceiptHeaderId;
  String  get itemId => _itemId;
  int     get lineNumber => _lineNumber;
  String  get itemName => _itemName;
  double  get purchQty => _purchQty;
  String  get purchUnit => _purchUnit;
  double  get purchPrice => _purchPrice;
  double  get lineAmount => _lineAmount;
  String  get inventLocationId => _inventLocationId;
  String  get wMSLocationId => _wMSLocationId;

  factory GoodsReceiptLineDtoBuilder.fromDto(GoodsReceiptLineDto goodsReceiptLineDto) {
    return GoodsReceiptLineDtoBuilder()
      .setGoodsReceiptLineId(goodsReceiptLineDto.goodsReceiptLineId)
      .setGoodsReceiptHeaderId(goodsReceiptLineDto.goodsReceiptHeaderId)
      .setItemId(goodsReceiptLineDto.itemId)
      .setLineNumber(goodsReceiptLineDto.lineNumber)
      .setItemName(goodsReceiptLineDto.itemName)
      .setPurchQty(goodsReceiptLineDto.purchQty)
      .setPurchUnit(goodsReceiptLineDto.purchUnit)
      .setPurchPrice(goodsReceiptLineDto.purchPrice)
      .setLineAmount(goodsReceiptLineDto.lineAmount)
      .setInventLocationId(goodsReceiptLineDto.inventLocationId)
      .setWMSLocationId(goodsReceiptLineDto.wMSLocationId);
  }

  GoodsReceiptLineDtoBuilder setGoodsReceiptLineId(int goodsReceiptLineId) {
    _goodsReceiptLineId = goodsReceiptLineId;
    return this;
  }

  GoodsReceiptLineDtoBuilder setGoodsReceiptHeaderId(int goodsReceiptHeaderId) {
    _goodsReceiptHeaderId = goodsReceiptHeaderId;
    return this;
  }

  GoodsReceiptLineDtoBuilder setItemId(String itemId) {
    _itemId = itemId;
    return this;
  }

  GoodsReceiptLineDtoBuilder setLineNumber(int lineNumber) {
    _lineNumber = lineNumber;
    return this;
  }

  GoodsReceiptLineDtoBuilder setItemName(String itemName) {
    _itemName = itemName;
    return this;
  }

  GoodsReceiptLineDtoBuilder setPurchQty(double purchQty) {
    _purchQty = purchQty;
    return this;
  }

  GoodsReceiptLineDtoBuilder setPurchUnit(String purchUnit) {
    _purchUnit = purchUnit;
    return this;
  }

  GoodsReceiptLineDtoBuilder setPurchPrice(double purchPrice) {
    _purchPrice = purchPrice;
    return this;
  }

  GoodsReceiptLineDtoBuilder setLineAmount(double lineAmount) {
    _lineAmount = lineAmount;
    return this;
  }

  GoodsReceiptLineDtoBuilder setInventLocationId(String inventLocationId) {
    _inventLocationId = inventLocationId;
    return this;
  }

  GoodsReceiptLineDtoBuilder setWMSLocationId(String wMSLocationId) {
    _wMSLocationId = wMSLocationId;
    return this;
  }

  GoodsReceiptLineDto build() {
    return GoodsReceiptLineDto(
      goodsReceiptLineId: _goodsReceiptLineId,
      goodsReceiptHeaderId: _goodsReceiptHeaderId,
      itemId: _itemId,
      lineNumber: _lineNumber,
      itemName: _itemName,
      purchQty: _purchQty,
      purchUnit: _purchUnit,
      purchPrice: _purchPrice,
      lineAmount: _lineAmount,
      inventLocationId: _inventLocationId,
      wMSLocationId: _wMSLocationId,
    );
  }
}