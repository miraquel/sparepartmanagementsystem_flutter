class WMSLocationSearchDto {
  final String inventLocationId;
  final String wMSLocationId;

  WMSLocationSearchDto({
    this.inventLocationId = '',
    this.wMSLocationId = '',
  });

  factory WMSLocationSearchDto.fromJson(Map<String, dynamic> json) => WMSLocationSearchDto(
    inventLocationId: json['inventLocationId'] as String? ?? '',
    wMSLocationId: json['wmsLocationId'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    if (inventLocationId.isNotEmpty) 'inventLocationId': inventLocationId,
    if (wMSLocationId.isNotEmpty) 'wmsLocationId': wMSLocationId,
  };

  bool isDefault() => inventLocationId.isEmpty && wMSLocationId.isEmpty;
}