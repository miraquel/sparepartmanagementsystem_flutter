class WorkOrderSearchDto {
  final String agseamwoid;

  WorkOrderSearchDto({
    this.agseamwoid = '',
  });

  factory WorkOrderSearchDto.fromJson(Map<String, dynamic> json) {
    return WorkOrderSearchDto(
      agseamwoid: json['agseamwoid'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (agseamwoid.isNotEmpty) 'agseamwoid': agseamwoid,
    };
  }
}