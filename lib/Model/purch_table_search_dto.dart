class PurchTableSearchDto {
  final String purchId;
  final String purchName;
  final String orderAccount;
  final String invoiceAccount;

  PurchTableSearchDto({
    this.purchId = '',
    this.purchName = '',
    this.orderAccount = '',
    this.invoiceAccount = '',
  });

  factory PurchTableSearchDto.fromJson(Map<String, dynamic> json) => PurchTableSearchDto(
    purchId: json['purchId'] as String,
    purchName: json['purchName'] as String,
    orderAccount: json['orderAccount'] as String,
    invoiceAccount: json['invoiceAccount'] as String,
  );

  Map<String, dynamic> toJson() => {
    if (purchId.isNotEmpty) 'purchId': purchId,
    if (purchName.isNotEmpty) 'purchName': purchName,
    if (orderAccount.isNotEmpty) 'orderAccount': orderAccount,
    if (invoiceAccount.isNotEmpty) 'invoiceAccount': invoiceAccount,
  };
}