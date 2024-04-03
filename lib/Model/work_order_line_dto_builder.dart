import 'package:decimal/decimal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto.dart';

import '../Helper/date_time_helper.dart';

class WorkOrderLineDtoBuilder {
  int _workOrderLineId = 0;
  int _workOrderHeaderId = 0;
  String _itemId = '';
  String _itemName = '';
  DateTime _requiredDate = DateTimeHelper.minDateTime;
  Decimal _quantity = Decimal.zero;
  Decimal _requestQuantity = Decimal.zero;
  String _inventLocationId = '';
  String _wMSLocationId = '';
  bool _isSelected = false;

  WorkOrderLineDtoBuilder();

  int get workOrderLineId => _workOrderLineId;
  int get workOrderHeaderId => _workOrderHeaderId;
  String get itemId => _itemId;
  String get itemName => _itemName;
  DateTime get requiredDate => _requiredDate;
  Decimal get quantity => _quantity;
  Decimal get requestQuantity => _requestQuantity;
  String get inventLocationId => _inventLocationId;
  String get wMSLocationId => _wMSLocationId;
  bool get isSelected => _isSelected;

  WorkOrderLineDtoBuilder setWorkOrderLineId(int workOrderLineId) {
    _workOrderLineId = workOrderLineId;
    return this;
  }

  WorkOrderLineDtoBuilder setWorkOrderHeaderId(int workOrderHeaderId) {
    _workOrderHeaderId = workOrderHeaderId;
    return this;
  }

  WorkOrderLineDtoBuilder setItemId(String itemId) {
    _itemId = itemId;
    return this;
  }

  WorkOrderLineDtoBuilder setItemName(String itemName) {
    _itemName = itemName;
    return this;
  }

  WorkOrderLineDtoBuilder setRequiredDate(DateTime requiredDate) {
    _requiredDate = requiredDate;
    return this;
  }

  WorkOrderLineDtoBuilder setQuantity(Decimal quantity) {
    _quantity = quantity;
    return this;
  }

  WorkOrderLineDtoBuilder setRequestQuantity(Decimal requestQuantity) {
    _requestQuantity = requestQuantity;
    return this;
  }

  WorkOrderLineDtoBuilder setInventLocationId(String inventLocationId) {
    _inventLocationId = inventLocationId;
    return this;
  }

  WorkOrderLineDtoBuilder setWMSLocationId(String wMSLocationId) {
    _wMSLocationId = wMSLocationId;
    return this;
  }

  WorkOrderLineDto build() {
    return WorkOrderLineDto(
      workOrderLineId: _workOrderLineId,
      workOrderHeaderId: _workOrderHeaderId,
      itemId: _itemId,
      itemName: _itemName,
      requiredDate: _requiredDate,
      quantity: _quantity,
      requestQuantity: _requestQuantity,
      inventLocationId: _inventLocationId,
      wMSLocationId: _wMSLocationId,
    );
  }

  factory WorkOrderLineDtoBuilder.fromDto(WorkOrderLineDto workOrderLineDto) {
    return WorkOrderLineDtoBuilder()
      .setWorkOrderLineId(workOrderLineDto.workOrderLineId)
      .setWorkOrderHeaderId(workOrderLineDto.workOrderHeaderId)
      .setItemId(workOrderLineDto.itemId)
      .setItemName(workOrderLineDto.itemName)
      .setRequiredDate(workOrderLineDto.requiredDate)
      .setQuantity(workOrderLineDto.quantity)
      .setRequestQuantity(workOrderLineDto.requestQuantity)
      .setInventLocationId(workOrderLineDto.inventLocationId)
      .setWMSLocationId(workOrderLineDto.wMSLocationId);
  }

  WorkOrderLineDtoBuilder setIsSelected(bool isSelected) {
    _isSelected = isSelected;
    return this;
  }
}