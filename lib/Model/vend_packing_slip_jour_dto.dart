import 'package:sparepartmanagementsystem_flutter/Model/vend_packing_slip_trans_dto.dart';

import 'package:sparepartmanagementsystem_flutter/Helper/date_time_helper.dart';

class VendPackingSlipJourDto {
  final String purchId;
  final String packingSlipId;
  final String internalPackingSlipId;
  final DateTime deliveryDate;
  final List<VendPackingSlipTransDto> vendPackingSlipTrans;

  VendPackingSlipJourDto({
    this.purchId = '',
    this.packingSlipId = '',
    this.internalPackingSlipId = '',
    DateTime? deliveryDate,
    List<VendPackingSlipTransDto>? vendPackingSlipTrans,
  }) : deliveryDate = deliveryDate ?? DateTimeHelper.today, vendPackingSlipTrans = vendPackingSlipTrans ?? [];

  factory VendPackingSlipJourDto.fromJson(Map<String, dynamic> json) {
    return VendPackingSlipJourDto(
      purchId: json['purchId'] ?? '',
      packingSlipId: json['packingSlipId'] ?? '',
      internalPackingSlipId: json['internalPackingSlipId'] ?? '',
      deliveryDate: DateTime.tryParse(json['deliveryDate'] ?? '') ?? DateTimeHelper.today,
      vendPackingSlipTrans: json['vendPackingSlipTrans']?.map<VendPackingSlipTransDto>((e) => VendPackingSlipTransDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'purchId': purchId,
      'packingSlipId': packingSlipId,
      'internalPackingSlipId': internalPackingSlipId,
      'deliveryDate': deliveryDate.toIso8601String(),
      'vendPackingSlipTrans': vendPackingSlipTrans.map((e) => e.toJson()).toList(),
    };
  }
}