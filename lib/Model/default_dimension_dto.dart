class DefaultDimensionDto {
  final String bank;
  final String brand;
  final String businessUnit;
  final String costCenter;
  final String custLevel2;
  final String customer;
  final String department;
  final String distributor;
  final String divisi;
  final String investment;
  final String subDistributor;
  final String worker;
  final String workerStatus;
  final String workerType;

  DefaultDimensionDto({
    this.bank = '',
    this.brand = '',
    this.businessUnit = '',
    this.costCenter = '',
    this.custLevel2 = '',
    this.customer = '',
    this.department = '',
    this.distributor = '',
    this.divisi = '',
    this.investment = '',
    this.subDistributor = '',
    this.worker = '',
    this.workerStatus = '',
    this.workerType = '',
  });

  factory DefaultDimensionDto.fromJson(Map<String, dynamic> json) {
    return DefaultDimensionDto(
      bank: json['bank'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      businessUnit: json['businessUnit'] as String? ?? '',
      costCenter: json['costCenter'] as String? ?? '',
      custLevel2: json['custLevel2'] as String? ?? '',
      customer: json['customer'] as String? ?? '',
      department: json['department'] as String? ?? '',
      distributor: json['distributor'] as String? ?? '',
      divisi: json['divisi'] as String? ?? '',
      investment: json['investment'] as String? ?? '',
      subDistributor: json['subDistributor'] as String? ?? '',
      worker: json['worker'] as String? ?? '',
      workerStatus: json['workerStatus'] as String? ?? '',
      workerType: json['workerType'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (bank.isNotEmpty) 'bank': bank,
      if (brand.isNotEmpty) 'brand': brand,
      if (businessUnit.isNotEmpty) 'businessUnit': businessUnit,
      if (costCenter.isNotEmpty) 'costCenter': costCenter,
      if (custLevel2.isNotEmpty) 'custLevel2': custLevel2,
      if (customer.isNotEmpty) 'customer': customer,
      if (department.isNotEmpty) 'department': department,
      if (distributor.isNotEmpty) 'distributor': distributor,
      if (divisi.isNotEmpty) 'divisi': divisi,
      if (investment.isNotEmpty) 'investment': investment,
      if (subDistributor.isNotEmpty) 'subDistributor': subDistributor,
      if (worker.isNotEmpty) 'worker': worker,
      if (workerStatus.isNotEmpty) 'workerStatus': workerStatus,
      if (workerType.isNotEmpty) 'workerType': workerType,
    };
  }
}