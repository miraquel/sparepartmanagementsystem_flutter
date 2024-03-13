class WMSLocationDto {
  final String inventLocationId;
  final String wMSLocationId;
  final String locationType;
  final int maxPalletCount;
  final double maxWeight;
  final double maxVolume;

  WMSLocationDto({
    this.inventLocationId = '',
    this.wMSLocationId = '',
    this.locationType = '',
    this.maxPalletCount = 0,
    this.maxWeight = 0,
    this.maxVolume = 0,
  });

  factory WMSLocationDto.fromJson(Map<String, dynamic> json) => WMSLocationDto(
    inventLocationId: json['inventLocationId'] as String? ?? '',
    wMSLocationId: json['wmsLocationId'] as String? ?? '',
    locationType: json['locationType'] as String? ?? '',
    maxPalletCount: json['maxPalletCount'] as int? ?? 0,
    maxWeight: json['maxWeight'] as double? ?? 0,
    maxVolume: json['maxVolume'] as double? ?? 0,
  );

  Map<String, dynamic> toJson() => {
    if (inventLocationId.isNotEmpty) 'inventLocationId': inventLocationId,
    if (wMSLocationId.isNotEmpty) 'wmsLocationId': wMSLocationId,
    if (locationType.isNotEmpty) 'locationType': locationType,
    if (maxPalletCount > 0) 'maxPalletCount': maxPalletCount,
    if (maxWeight > 0) 'maxWeight': maxWeight,
    if (maxVolume > 0) 'maxVolume': maxVolume,
  };

  bool isDefault() => inventLocationId.isEmpty && wMSLocationId.isEmpty && locationType.isEmpty && maxPalletCount == 0 && maxWeight == 0 && maxVolume == 0;
}