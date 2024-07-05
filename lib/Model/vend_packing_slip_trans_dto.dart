class VendPackingSlipTransDto {
  // public string ItemId { get; set; } = string.Empty;
  // public string ItemName { get; set; } = string.Empty;
  // public int Qty { get; set; }

  final String itemId;
  final String itemName;
  final int qty;

  VendPackingSlipTransDto({
    this.itemId = '',
    this.itemName = '',
    this.qty = 0,
  });

  factory VendPackingSlipTransDto.fromJson(Map<String, dynamic> json) {
    return VendPackingSlipTransDto(
      itemId: json['itemId'] ?? '',
      itemName: json['itemName'] ?? '',
      qty: json['qty'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'qty': qty,
    };
  }
}