class PurchTableSearchDto {
  final String purchId;
  final String purchName;

  PurchTableSearchDto({
    this.purchId = '',
    this.purchName = '',
  });

  factory PurchTableSearchDto.fromJson(Map<String, dynamic> json) => PurchTableSearchDto(
    purchId: json['purchId'] as String,
    purchName: json['purchName'] as String,
  );

  Map<String, dynamic> toJson() => {
    if (purchId.isNotEmpty) 'purchId': purchId,
    if (purchName.isNotEmpty) 'purchName': purchName,
  };
}