class VersionTrackerDto {
  final int versionTrackerId;
  final String version;
  final String description;
  final String physicalLocation;
  final String createdBy;
  final DateTime createdDateTime;
  final String modifiedBy;
  final DateTime modifiedDateTime;

  VersionTrackerDto({
    this.versionTrackerId = 0,
    this.version = '',
    this.description = '',
    this.physicalLocation = '',
    this.createdBy = '',
    DateTime? createdDateTime,
    this.modifiedBy = '',
    DateTime? modifiedDateTime,
  }) :  createdDateTime = createdDateTime ?? DateTime.now(),
        modifiedDateTime = modifiedDateTime ?? DateTime.now();

  factory VersionTrackerDto.fromJson(Map<String, dynamic> json) {
    return VersionTrackerDto(
      versionTrackerId: json['versionTrackerId'] as int? ?? 0,
      version: json['version'] as String? ?? '',
      description: json['description'] as String? ?? '',
      physicalLocation: json['physicalLocation'] as String? ?? '',
      createdBy: json['createdBy'] as String? ?? '',
      createdDateTime: DateTime.tryParse(json['createdDateTime'] as String? ?? '') ?? DateTime.now(),
      modifiedBy: json['modifiedBy'] as String? ?? '',
      modifiedDateTime: DateTime.tryParse(json['modifiedDateTime'] as String? ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (versionTrackerId != 0) 'versionTrackerId': versionTrackerId,
      if (version.isNotEmpty) 'version': version,
      if (description.isNotEmpty) 'description': description,
      if (physicalLocation.isNotEmpty) 'physicalLocation': physicalLocation,
      if (createdBy.isNotEmpty) 'createdBy': createdBy,
      if (createdDateTime.isAfter(DateTime.now())) 'createdDateTime': createdDateTime.toIso8601String(),
      if (modifiedBy.isNotEmpty) 'modifiedBy': modifiedBy,
      if (modifiedDateTime.isAfter(DateTime.now())) 'modifiedDateTime': modifiedDateTime.toIso8601String(),
    };
  }
}