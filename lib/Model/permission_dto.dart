class PermissionDto {
  final int permissionId;
  final String module;
  final String type;
  final String permissionName;
  final int roleId;

  PermissionDto({
    this.permissionId = 0,
    this.module = '',
    this.type = '',
    this.permissionName = '',
    this.roleId = 0,
  });

  factory PermissionDto.fromJson(Map<String, dynamic> json) => PermissionDto(
    permissionId: json['permissionId'] as int,
    module: json['module'] as String,
    type: json['type'] as String,
    permissionName: json['permissionName'] as String,
    roleId: json['roleId'] as int,
  );

  Map<String, dynamic> toJson() => {
    if (permissionId > 0) 'permissionId': permissionId,
    if (module.isNotEmpty) 'module': module,
    if (type.isNotEmpty) 'type': type,
    if (permissionName.isNotEmpty) 'permissionName': permissionName,
    if (roleId > 0) 'roleId': roleId,
  };
}
