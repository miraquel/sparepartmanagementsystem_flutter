class DimensionDto {
  final String description;
  final String value;

  DimensionDto({
    this.description = '',
    this.value = '',
  });

  factory DimensionDto.fromJson(Map<String, dynamic> json) {
    return DimensionDto(
      description: json['description'] as String? ?? '',
      value: json['value'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (description.isNotEmpty) 'description': description,
      if (value.isNotEmpty) 'value': value,
    };
  }
}