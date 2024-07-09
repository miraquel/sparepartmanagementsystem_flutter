class WorkOrderHeaderSearchDto {
  final String agseamwoid;
  final String agseamwrid;
  final String agseamwoStatusID;

  WorkOrderHeaderSearchDto({
    this.agseamwoid = '',
    this.agseamwrid = '',
    this.agseamwoStatusID = '',
  });

  Map<String, dynamic> toJson() {
    return {
      if (agseamwoid.isNotEmpty) 'agseamwoid': agseamwoid,
      if (agseamwrid.isNotEmpty) 'agseamwrid': agseamwrid,
      if (agseamwoStatusID.isNotEmpty) 'agseamwoStatusID': agseamwoStatusID,
    };
  }

  factory WorkOrderHeaderSearchDto.fromJson(Map<String, dynamic> json) => WorkOrderHeaderSearchDto(
    agseamwoid: json['agseamwoid'] as String? ?? '',
    agseamwrid: json['agseamwrid'] as String? ?? '',
    agseamwoStatusID: json['agseamwoStatusID'] as String? ?? '',
  );
}