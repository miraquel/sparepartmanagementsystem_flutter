import 'package:sparepartmanagementsystem_flutter/Model/default_dimension_dto.dart';

class DefaultDimensionDtoBuilder {
  String _bank = '';
  String _brand = '';
  String _businessUnit = '';
  String _costCenter = '';
  String _custLevel2 = '';
  String _customer = '';
  String _department = '';
  String _distributor = '';
  String _divisi = '';
  String _investment = '';
  String _subDistributor = '';
  String _worker = '';
  String _workerStatus = '';
  String _workerType = '';

  DefaultDimensionDtoBuilder();

  String get bank => _bank;
  String get brand => _brand;
  String get businessUnit => _businessUnit;
  String get costCenter => _costCenter;
  String get custLevel2 => _custLevel2;
  String get customer => _customer;
  String get department => _department;
  String get distributor => _distributor;
  String get divisi => _divisi;
  String get investment => _investment;
  String get subDistributor => _subDistributor;
  String get worker => _worker;
  String get workerStatus => _workerStatus;
  String get workerType => _workerType;

  DefaultDimensionDtoBuilder setBank(String bank) {
    _bank = bank;
    return this;
  }

  DefaultDimensionDtoBuilder setBrand(String brand) {
    _brand = brand;
    return this;
  }

  DefaultDimensionDtoBuilder setBusinessUnit(String businessUnit) {
    _businessUnit = businessUnit;
    return this;
  }

  DefaultDimensionDtoBuilder setCostCenter(String costCenter) {
    _costCenter = costCenter;
    return this;
  }

  DefaultDimensionDtoBuilder setCustLevel2(String custLevel2) {
    _custLevel2 = custLevel2;
    return this;
  }

  DefaultDimensionDtoBuilder setCustomer(String customer) {
    _customer = customer;
    return this;
  }

  DefaultDimensionDtoBuilder setDepartment(String department) {
    _department = department;
    return this;
  }

  DefaultDimensionDtoBuilder setDistributor(String distributor) {
    _distributor = distributor;
    return this;
  }

  DefaultDimensionDtoBuilder setDivisi(String divisi) {
    _divisi = divisi;
    return this;
  }

  DefaultDimensionDtoBuilder setInvestment(String investment) {
    _investment = investment;
    return this;
  }

  DefaultDimensionDtoBuilder setSubDistributor(String subDistributor) {
    _subDistributor = subDistributor;
    return this;
  }

  DefaultDimensionDtoBuilder setWorker(String worker) {
    _worker = worker;
    return this;
  }

  DefaultDimensionDtoBuilder setWorkerStatus(String workerStatus) {
    _workerStatus = workerStatus;
    return this;
  }

  DefaultDimensionDtoBuilder setWorkerType(String workerType) {
    _workerType = workerType;
    return this;
  }

  DefaultDimensionDto build() {
    return DefaultDimensionDto(
      bank: _bank,
      brand: _brand,
      businessUnit: _businessUnit,
      costCenter: _costCenter,
      custLevel2: _custLevel2,
      customer: _customer,
      department: _department,
      distributor: _distributor,
      divisi: _divisi,
      investment: _investment,
      subDistributor: _subDistributor,
      worker: _worker,
      workerStatus: _workerStatus,
      workerType: _workerType,
    );
  }

  factory DefaultDimensionDtoBuilder.fromDto(DefaultDimensionDto dto) {
    return DefaultDimensionDtoBuilder()
      .._bank = dto.bank
      .._brand = dto.brand
      .._businessUnit = dto.businessUnit
      .._costCenter = dto.costCenter
      .._custLevel2 = dto.custLevel2
      .._customer = dto.customer
      .._department = dto.department
      .._distributor = dto.distributor
      .._divisi = dto.divisi
      .._investment = dto.investment
      .._subDistributor = dto.subDistributor
      .._worker = dto.worker
      .._workerStatus = dto.workerStatus
      .._workerType = dto.workerType;
  }

  DefaultDimensionDtoBuilder setFromDto(DefaultDimensionDto dto) {
    _bank = dto.bank;
    _brand = dto.brand;
    _businessUnit = dto.businessUnit;
    _costCenter = dto.costCenter;
    _custLevel2 = dto.custLevel2;
    _customer = dto.customer;
    _department = dto.department;
    _distributor = dto.distributor;
    _divisi = dto.divisi;
    _investment = dto.investment;
    _subDistributor = dto.subDistributor;
    _worker = dto.worker;
    _workerStatus = dto.workerStatus;
    _workerType = dto.workerType;
    return this;
  }
}