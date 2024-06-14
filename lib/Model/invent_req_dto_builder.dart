
import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Constants/no_yes.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_req_dto.dart';

class InventReqDtoBuilder {
  String _itemId = '';
  String _productName = '';
  DateTime _requiredDate = DateTimeHelper.minDateTime;
  double _qty = 0;
  int _unitOfMeasure = 0;
  String _currency = '';
  double _costPrice = 0;
  double _costAmount = 0;
  String _inventSiteId = '';
  String _inventLocationId = '';
  String _wmsLocationId = '';
  int _agswoRecId = 0;
  NoYes _process = NoYes.no;
  String _preparerUserId = '';
  String _createdBy = '';
  DateTime _createdDateTime = DateTimeHelper.minDateTime;
  String _modifiedBy = '';
  DateTime _modifiedDateTime = DateTimeHelper.minDateTime;
  int _recId = 0;
  bool _isSelected = false;

  InventReqDtoBuilder();

  String get itemId => _itemId;
  String get productName => _productName;
  DateTime get requiredDate => _requiredDate;
  double get qty => _qty;
  int get unitOfMeasure => _unitOfMeasure;
  String get currency => _currency;
  double get costPrice => _costPrice;
  double get costAmount => _costAmount;
  String get inventSiteId => _inventSiteId;
  String get inventLocationId => _inventLocationId;
  String get wmsLocationId => _wmsLocationId;
  int get agsWoRecId => _agswoRecId;
  NoYes get process => _process;
  String get preparerUserId => _preparerUserId;
  String get createdBy => _createdBy;
  DateTime get createdDateTime => _createdDateTime;
  String get modifiedBy => _modifiedBy;
  DateTime get modifiedDateTime => _modifiedDateTime;
  int get recId => _recId;
  bool get isSelected => _isSelected;

  InventReqDtoBuilder setItemId(String itemId) {
    _itemId = itemId;
    return this;
  }

  InventReqDtoBuilder setProductName(String productName) {
    _productName = productName;
    return this;
  }

  InventReqDtoBuilder setRequiredDate(DateTime requiredDate) {
    _requiredDate = requiredDate;
    return this;
  }

  InventReqDtoBuilder setQty(double qty) {
    _qty = qty;
    return this;
  }

  InventReqDtoBuilder setUnitOfMeasure(int unitOfMeasure) {
    _unitOfMeasure = unitOfMeasure;
    return this;
  }

  InventReqDtoBuilder setCurrency(String currency) {
    _currency = currency;
    return this;
  }

  InventReqDtoBuilder setCostPrice(double costPrice) {
    _costPrice = costPrice;
    return this;
  }

  InventReqDtoBuilder setCostAmount(double costAmount) {
    _costAmount = costAmount;
    return this;
  }

  InventReqDtoBuilder setInventLocationId(String inventLocationId) {
    _inventLocationId = inventLocationId;
    return this;
  }

  InventReqDtoBuilder setInventSiteId(String inventSiteId) {
    _inventSiteId = inventSiteId;
    return this;
  }

  InventReqDtoBuilder setWmsLocationId(String wmsLocationId) {
    _wmsLocationId = wmsLocationId;
    return this;
  }

  InventReqDtoBuilder setProcess(NoYes process) {
    _process = process;
    return this;
  }

  InventReqDtoBuilder setAgswoRecId(int agsWoRecId) {
    _agswoRecId = agsWoRecId;
    return this;
  }

  InventReqDtoBuilder setPreparedUserId(String preparedUserId) {
    _preparerUserId = preparedUserId;
    return this;
  }

  InventReqDtoBuilder setCreatedBy(String createdBy) {
    _createdBy = createdBy;
    return this;
  }
  
  InventReqDtoBuilder setCreatedDateTime(DateTime createdDateTime) {
    _createdDateTime = createdDateTime;
    return this;
  }
  
  InventReqDtoBuilder setModifiedBy(String modifiedBy) {
    _modifiedBy = modifiedBy;
    return this;
  }
  
  InventReqDtoBuilder setModifiedDateTime(DateTime modifiedDateTime) {
    _modifiedDateTime = modifiedDateTime;
    return this;
  }
  
  InventReqDtoBuilder setRecId(int recId) {
    _recId = recId;
    return this;
  }

  InventReqDtoBuilder setIsSelected(bool isSelected) {
    _isSelected = isSelected;
    return this;
  }

  InventReqDtoBuilder setFromInventReqDto(InventReqDto inventReqDto) {
    _itemId = inventReqDto.itemId;
    _productName = inventReqDto.productName;
    _requiredDate = inventReqDto.requiredDate;
    _qty = inventReqDto.qty;
    _unitOfMeasure = inventReqDto.unitOfMeasure;
    _currency = inventReqDto.currency;
    _costPrice = inventReqDto.costPrice;
    _costAmount = inventReqDto.costAmount;
    _inventSiteId = inventReqDto.inventSiteId;
    _inventLocationId = inventReqDto.inventLocationId;
    _wmsLocationId = inventReqDto.wmsLocationId;
    _agswoRecId = inventReqDto.agswoRecId;
    _process = inventReqDto.process;
    _preparerUserId = inventReqDto.preparerUserId;
    _createdBy = inventReqDto.createdBy;
    _createdDateTime = inventReqDto.createdDateTime;
    _modifiedBy = inventReqDto.modifiedBy;
    _modifiedDateTime = inventReqDto.modifiedDateTime;
    _recId = inventReqDto.recId;
    return this;
  }

  factory InventReqDtoBuilder.fromDto(InventReqDto inventReqDto) {
    return InventReqDtoBuilder().setFromInventReqDto(inventReqDto);
  }
  
  InventReqDto build() {
    return InventReqDto(
      itemId: _itemId,
      productName: _productName,
      requiredDate: _requiredDate,
      qty: _qty,
      unitOfMeasure: _unitOfMeasure,
      currency: _currency,
      costPrice: _costPrice,
      costAmount: _costAmount,
      inventSiteId: _inventSiteId,
      inventLocationId: _inventLocationId,
      wmsLocationId: _wmsLocationId,
      agswoRecId: _agswoRecId,
      process: _process,
      preparerUserId: _preparerUserId,
      createdBy: _createdBy,
      createdDateTime: _createdDateTime,
      modifiedBy: _modifiedBy,
      modifiedDateTime: _modifiedDateTime,
      recId: _recId,
    );
  }
}