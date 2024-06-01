class InventLocationDto {
  final String inventLocationId;
  final String inventSiteId;
  final String name;

  InventLocationDto({
    this.inventLocationId = '',
    this.inventSiteId = '',
    this.name = '',
  });

  factory InventLocationDto.fromJson(Map<String, dynamic> json) {
    return InventLocationDto(
      inventLocationId: json['inventLocationId'],
      inventSiteId: json['inventSiteId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (inventLocationId.isNotEmpty) 'inventLocationId': inventLocationId,
      if (inventSiteId.isNotEmpty) 'inventSiteId': inventSiteId,
      if (name.isNotEmpty) 'name': name,
    };
  }
}