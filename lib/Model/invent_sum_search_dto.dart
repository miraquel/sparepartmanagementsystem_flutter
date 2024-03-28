class InventSumSearchDto {
  final String itemId;
  final String inventLocationId;
  final String wMSLocationId;

  InventSumSearchDto({
    this.itemId = '',
    this.inventLocationId = '',
    this.wMSLocationId = '',
  });

  factory InventSumSearchDto.fromJson(Map<String, dynamic> json) {
    return InventSumSearchDto(
      itemId: json['itemId'] as String? ?? '',
      inventLocationId: json['inventLocationId'] as String? ?? '',
      wMSLocationId: json['wmsLocationId'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (itemId.isNotEmpty) 'itemId': itemId,
      if (inventLocationId.isNotEmpty) 'inventLocationId': inventLocationId,
      if (wMSLocationId.isNotEmpty) 'wmsLocationId': wMSLocationId,
    };
  }
}

