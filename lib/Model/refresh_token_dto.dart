import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';

class RefreshTokenDto {
  final int refreshTokenId;
  final int userId;
  final String token;
  final DateTime expires;
  final DateTime created;
  final DateTime revoked;
  final String replacedByToken;
  final bool? isActive;
  final bool? isExpired;

  RefreshTokenDto({
    this.refreshTokenId = 0,
    this.userId = 0,
    this.token = '',
    DateTime? expires,
    DateTime? created,
    DateTime? revoked,
    this.replacedByToken = '',
    this.isActive,
    this.isExpired
  }) : expires = expires ?? DateTimeHelper.minDateTime, created = created ?? DateTimeHelper.minDateTime, revoked = revoked ?? DateTimeHelper.minDateTime;

  factory RefreshTokenDto.fromJson(Map<String, dynamic> json) => RefreshTokenDto(
    refreshTokenId: json['refreshTokenId'] as int,
    userId: json['userId'] as int,
    token: json['token'] as String,
    expires: DateTime.parse(json['expires'] as String),
    created: DateTime.parse(json['created'] as String),
    revoked: DateTime.parse(json['revoked'] as String),
    replacedByToken: json['replacedByToken'] as String,
    isActive: json['isActive'] as bool,
    isExpired: json['isExpired'] as bool
  );

  Map<String, dynamic> toJson() => {
    if (refreshTokenId > 0) 'refreshTokenId': refreshTokenId,
    if (userId > 0) 'userId': userId,
    if (token.isNotEmpty) 'token': token,
    if (expires.isAfter(DateTimeHelper.minDateTime)) 'expires': expires.toIso8601String(),
    if (created.isAfter(DateTimeHelper.minDateTime)) 'created': created.toIso8601String(),
    if (revoked.isAfter(DateTimeHelper.minDateTime)) 'revoked': revoked.toIso8601String(),
    if (replacedByToken.isNotEmpty) 'replacedByToken': replacedByToken,
    if (isActive != null) 'isActive': isActive,
    if (isExpired != null) 'isExpired': isExpired
  };
}
