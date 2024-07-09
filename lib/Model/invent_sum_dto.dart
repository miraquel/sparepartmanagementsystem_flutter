class InventSumDto {
  final String itemId;
  final String itemName;
  final String inventSiteId;
  final String inventLocationId;
  final String wMSLocationId;
  final double physicalInvent;
  final double reservPhysical;
  final double availPhysical;
  final double orderedSum;
  final double onOrder;
  final double reservOrdered;
  final double availOrdered;

  InventSumDto({
    this.itemId = '',
    this.itemName = '',
    this.inventSiteId = '',
    this.inventLocationId = '',
    this.wMSLocationId = '',
    this.physicalInvent = 0,
    this.reservPhysical = 0,
    this.availPhysical = 0,
    this.orderedSum = 0,
    this.onOrder = 0,
    this.reservOrdered = 0,
    this.availOrdered = 0,
  });

  factory InventSumDto.fromJson(Map<String, dynamic> json) {
    return InventSumDto(
      itemId: json['itemId'] as String? ?? '',
      itemName: json['itemName'] as String? ?? '',
      inventSiteId: json['inventSiteId'] as String? ?? '',
      inventLocationId: json['inventLocationId'] as String? ?? '',
      wMSLocationId: json['wmsLocationId'] as String? ?? '',
      physicalInvent: json['physicalInvent'] as double? ?? 0,
      reservPhysical: json['reservPhysical'] as double? ?? 0,
      availPhysical: json['availPhysical'] as double? ?? 0,
      orderedSum: json['orderedSum'] as double? ?? 0,
      onOrder: json['onOrder'] as double? ?? 0,
      reservOrdered: json['reservOrdered'] as double? ?? 0,
      availOrdered: json['availOrdered'] as double? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (itemId.isNotEmpty) 'itemId': itemId,
      if (itemName.isNotEmpty) 'itemName': itemName,
      if (inventSiteId.isNotEmpty) 'inventSiteId': inventSiteId,
      if (inventLocationId.isNotEmpty) 'inventLocationId': inventLocationId,
      if (wMSLocationId.isNotEmpty) 'wmsLocationId': wMSLocationId,
      if (physicalInvent != 0) 'physicalInvent': physicalInvent,
      if (reservPhysical != 0) 'reservPhysical': reservPhysical,
      if (availPhysical != 0) 'availPhysical': availPhysical,
      if (orderedSum != 0) 'orderedSum': orderedSum,
      if (onOrder != 0) 'onOrder': onOrder,
      if (reservOrdered != 0) 'reservOrdered': reservOrdered,
      if (availOrdered != 0) 'availOrdered': availOrdered,
    };
  }
}