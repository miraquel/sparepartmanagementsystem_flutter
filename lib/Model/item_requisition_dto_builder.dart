import 'package:decimal/decimal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/item_requisition_dto.dart';

import '../Helper/date_time_helper.dart';

class ItemRequisitionDtoBuilder {
  int _itemRequisitionId = 0;
  int _workOrderLineId = 0;
  String _itemId = '';
  String _itemName = '';
  DateTime _requiredDate = DateTimeHelper.minDateTime;
  Decimal _quantity = Decimal.zero;
  Decimal _requestQuantity = Decimal.zero;
  String _inventLocationId = '';
  String _wMSLocationId = '';
  bool _isSelected = false;

  ItemRequisitionDtoBuilder();

  int get itemRequisitionId => _itemRequisitionId;
  int get workOrderLineId => _workOrderLineId;
  String get itemId => _itemId;
  String get itemName => _itemName;
  DateTime get requiredDate => _requiredDate;
  Decimal get quantity => _quantity;
  Decimal get requestQuantity => _requestQuantity;
  String get inventLocationId => _inventLocationId;
  String get wMSLocationId => _wMSLocationId;
  bool get isSelected => _isSelected;

  ItemRequisitionDtoBuilder setItemRequisitionId(int itemRequisitionId) {
    _itemRequisitionId = itemRequisitionId;
    return this;
  }

  ItemRequisitionDtoBuilder setWorkOrderLineId(int workOrderLineId) {
    _workOrderLineId = workOrderLineId;
    return this;
  }

  ItemRequisitionDtoBuilder setItemId(String itemId) {
    _itemId = itemId;
    return this;
  }

  ItemRequisitionDtoBuilder setItemName(String itemName) {
    _itemName = itemName;
    return this;
  }

  ItemRequisitionDtoBuilder setRequiredDate(DateTime requiredDate) {
    _requiredDate = requiredDate;
    return this;
  }

  ItemRequisitionDtoBuilder setQuantity(Decimal quantity) {
    _quantity = quantity;
    return this;
  }

  ItemRequisitionDtoBuilder setRequestQuantity(Decimal requestQuantity) {
    _requestQuantity = requestQuantity;
    return this;
  }

  ItemRequisitionDtoBuilder setInventLocationId(String inventLocationId) {
    _inventLocationId = inventLocationId;
    return this;
  }

  ItemRequisitionDtoBuilder setWMSLocationId(String wMSLocationId) {
    _wMSLocationId = wMSLocationId;
    return this;
  }

  ItemRequisitionDto build() {
    return ItemRequisitionDto(
      itemRequisitionId: _itemRequisitionId,
      workOrderLineId: _workOrderLineId,
      itemId: _itemId,
      itemName: _itemName,
      requiredDate: _requiredDate,
      quantity: _quantity,
      requestQuantity: _requestQuantity,
      inventLocationId: _inventLocationId,
      wMSLocationId: _wMSLocationId,
    );
  }

  factory ItemRequisitionDtoBuilder.fromDto(ItemRequisitionDto workOrderLineDto) {
    return ItemRequisitionDtoBuilder()
      .setItemRequisitionId(workOrderLineDto.itemRequisitionId)
      .setWorkOrderLineId(workOrderLineDto.workOrderLineId)
      .setItemId(workOrderLineDto.itemId)
      .setItemName(workOrderLineDto.itemName)
      .setRequiredDate(workOrderLineDto.requiredDate)
      .setQuantity(workOrderLineDto.quantity)
      .setRequestQuantity(workOrderLineDto.requestQuantity)
      .setInventLocationId(workOrderLineDto.inventLocationId)
      .setWMSLocationId(workOrderLineDto.wMSLocationId);
  }

  ItemRequisitionDtoBuilder setIsSelected(bool isSelected) {
    _isSelected = isSelected;
    return this;
  }
}