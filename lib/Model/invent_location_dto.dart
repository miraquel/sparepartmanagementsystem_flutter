class InventLocationDto {
  final String inventLocationId;
  final String name;

  InventLocationDto({
    this.inventLocationId = '',
    this.name = '',
  });

  factory InventLocationDto.fromJson(Map<String, dynamic> json) {
    return InventLocationDto(
      inventLocationId: json['inventLocationId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (inventLocationId.isNotEmpty) 'inventLocationId': inventLocationId,
      if (name.isNotEmpty) 'name': name,
    };
  }
}