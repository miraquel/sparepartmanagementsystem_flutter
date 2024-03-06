class PurchTableDto {
  final String purchId;
  final String purchName;
  final String orderAccount;
  final String invoiceAccount;
  final String purchStatus;

  PurchTableDto({
    this.purchId = '',
    this.purchName = '',
    this.orderAccount = '',
    this.invoiceAccount = '',
    this.purchStatus = '',
  });

  factory PurchTableDto.fromJson(Map<String, dynamic> json) => PurchTableDto(
    purchId: json['purchId'] as String,
    purchName: json['purchName'] as String,
    orderAccount: json['orderAccount'] as String,
    invoiceAccount: json['invoiceAccount'] as String,
    purchStatus: json['purchStatus'] as String,
  );

  Map<String, dynamic> toJson() => {
    if (purchId.isNotEmpty) 'purchId': purchId,
    if (purchName.isNotEmpty) 'purchName': purchName,
    if (orderAccount.isNotEmpty) 'orderAccount': orderAccount,
    if (invoiceAccount.isNotEmpty) 'invoiceAccount': invoiceAccount,
    if (purchStatus.isNotEmpty) 'purchStatus': purchStatus,
  };

  bool isDefault() {
    return purchId.isEmpty && purchName.isEmpty && orderAccount.isEmpty && invoiceAccount.isEmpty && purchStatus.isEmpty;
  }
}