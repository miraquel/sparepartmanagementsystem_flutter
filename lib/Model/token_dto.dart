class TokenDto {
  final String accessToken;
  final String refreshToken;

  TokenDto({
    this.accessToken = '',
    this.refreshToken = ''
  });

  factory TokenDto.fromJson(Map<String, dynamic> json) => TokenDto(
    accessToken: json['accessToken'] as String? ?? '',
    refreshToken: json['refreshToken'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    if (accessToken.isNotEmpty) 'accessToken': accessToken,
    if (refreshToken.isNotEmpty) 'refreshToken': refreshToken,
  };
}
