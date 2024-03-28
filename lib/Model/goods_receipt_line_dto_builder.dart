import 'package:sparepartmanagementsystem_flutter/Model/Enums/product_type.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_line_dto.dart';

import 'goods_receipt_line_dto.dart';

class GoodsReceiptLineDtoBuilder {
  int _goodsReceiptLineId = 0;
  int _goodsReceiptHeaderId = 0;
  String _itemId = '';
  int _lineNumber = 0;
  String _itemName = '';
  ProductType _productType = ProductType.none;
  double _remainPurchPhysical = 0;
  double _receiveNow = 0;
  double _purchQty = 0;
  String _purchUnit = '';
  double _purchPrice = 0;
  double _lineAmount = 0;
  String _inventLocationId = '';
  String _wMSLocationId = '';
  bool _isSelected = false;

  GoodsReceiptLineDtoBuilder();

  int         get goodsReceiptLineId => _goodsReceiptLineId;
  int         get goodsReceiptHeaderId => _goodsReceiptHeaderId;
  String      get itemId => _itemId;
  int         get lineNumber => _lineNumber;
  String      get itemName => _itemName;
  ProductType get productType => _productType;
  double      get remainPurchPhysical => _remainPurchPhysical;
  double      get receiveNow => _receiveNow;
  double      get purchQty => _purchQty;
  String      get purchUnit => _purchUnit;
  double      get purchPrice => _purchPrice;
  double      get lineAmount => _lineAmount;
  String      get inventLocationId => _inventLocationId;
  String      get wMSLocationId => _wMSLocationId;
  bool        get isSelected => _isSelected;

  factory GoodsReceiptLineDtoBuilder.fromDto(GoodsReceiptLineDto goodsReceiptLineDto) {
    return GoodsReceiptLineDtoBuilder()
      .setGoodsReceiptLineId(goodsReceiptLineDto.goodsReceiptLineId)
      .setGoodsReceiptHeaderId(goodsReceiptLineDto.goodsReceiptHeaderId)
      .setItemId(goodsReceiptLineDto.itemId)
      .setLineNumber(goodsReceiptLineDto.lineNumber)
      .setItemName(goodsReceiptLineDto.itemName)
      .setProductType(goodsReceiptLineDto.productType)
      .setRemainPurchPhysical(goodsReceiptLineDto.remainPurchPhysical)
      .setReceiveNow(goodsReceiptLineDto.receiveNow)
      .setPurchQty(goodsReceiptLineDto.purchQty)
      .setPurchUnit(goodsReceiptLineDto.purchUnit)
      .setPurchPrice(goodsReceiptLineDto.purchPrice)
      .setLineAmount(goodsReceiptLineDto.lineAmount)
      .setInventLocationId(goodsReceiptLineDto.inventLocationId)
      .setWMSLocationId(goodsReceiptLineDto.wMSLocationId);
  }

  factory GoodsReceiptLineDtoBuilder.fromPurchLineDto(PurchLineDto purchLineDto) {
    return GoodsReceiptLineDtoBuilder()
      .setItemId(purchLineDto.itemId)
      .setLineNumber(purchLineDto.lineNumber)
      .setItemName(purchLineDto.itemName)
      .setProductType(purchLineDto.productType)
      .setRemainPurchPhysical(purchLineDto.remainPurchPhysical)
      .setPurchQty(purchLineDto.purchQty)
      .setPurchUnit(purchLineDto.purchUnit)
      .setPurchPrice(purchLineDto.purchPrice)
      .setLineAmount(purchLineDto.lineAmount)
      .setReceiveNow(purchLineDto.remainPurchPhysical);
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

  GoodsReceiptLineDtoBuilder setProductType(ProductType productType) {
    _productType = productType;
    return this;
  }

  GoodsReceiptLineDtoBuilder setRemainPurchPhysical(double remainPurchPhysical) {
    _remainPurchPhysical = remainPurchPhysical;
    return this;
  }

  GoodsReceiptLineDtoBuilder setReceiveNow(double receiveNow) {
    _receiveNow = receiveNow;
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

  GoodsReceiptLineDtoBuilder setIsSelected(bool isSelected) {
    _isSelected = isSelected;
    return this;
  }

  bool compareWithPurchLine(PurchLineDto purchLineDto) {
    return _itemId == purchLineDto.itemId &&
        _lineNumber == purchLineDto.lineNumber &&
        _itemName == purchLineDto.itemName &&
        _productType == purchLineDto.productType &&
        _remainPurchPhysical == purchLineDto.remainPurchPhysical &&
        _purchQty == purchLineDto.purchQty &&
        _purchUnit == purchLineDto.purchUnit &&
        _purchPrice == purchLineDto.purchPrice &&
        _lineAmount == purchLineDto.lineAmount;
  }

  GoodsReceiptLineDtoBuilder updateFromPurchLine(PurchLineDto purchLineDto) {
    _itemId = purchLineDto.itemId;
    _lineNumber = purchLineDto.lineNumber;
    _itemName = purchLineDto.itemName;
    _productType = purchLineDto.productType;
    _remainPurchPhysical = purchLineDto.remainPurchPhysical;
    _purchQty = purchLineDto.purchQty;
    _purchUnit = purchLineDto.purchUnit;
    _purchPrice = purchLineDto.purchPrice;
    _lineAmount = purchLineDto.lineAmount;
    if (_receiveNow > purchLineDto.remainPurchPhysical) {
      _receiveNow = purchLineDto.remainPurchPhysical;
    }
    return this;
  }

  GoodsReceiptLineDto build() {
    return GoodsReceiptLineDto(
      goodsReceiptLineId: _goodsReceiptLineId,
      goodsReceiptHeaderId: _goodsReceiptHeaderId,
      itemId: _itemId,
      lineNumber: _lineNumber,
      itemName: _itemName,
      productType: _productType,
      remainPurchPhysical: _remainPurchPhysical,
      receiveNow: _receiveNow,
      purchQty: _purchQty,
      purchUnit: _purchUnit,
      purchPrice: _purchPrice,
      lineAmount: _lineAmount,
      inventLocationId: _inventLocationId,
      wMSLocationId: _wMSLocationId,
    );
  }
}