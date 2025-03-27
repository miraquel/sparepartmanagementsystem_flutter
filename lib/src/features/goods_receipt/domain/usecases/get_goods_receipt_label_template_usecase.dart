import 'package:sparepartmanagementsystem_flutter/src/core/usecase/usecase.dart';
import 'package:sparepartmanagementsystem_flutter/src/core/resources/data_state.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/data/model/goods_receipt_header_model.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/domain/repositories/goods_receipt_repository.dart';

class GetGoodsReceiptLabelTemplateParams {
  final GoodsReceiptHeaderModel model;
  final int copies;

  GetGoodsReceiptLabelTemplateParams({
    required this.model,
    required this.copies,
  });
}

class GetGoodsReceiptLabelTemplateUsecase implements UseCase<DataState<String>, GetGoodsReceiptLabelTemplateParams> {
  final GoodsReceiptRepository repository;

  GetGoodsReceiptLabelTemplateUsecase(this.repository);

  @override
  Future<DataState<String>> call({GetGoodsReceiptLabelTemplateParams? params}) async {
    return await repository.getGoodsReceiptLabelTemplate(
      params!.model,
      params.copies,
    );
  }
}
