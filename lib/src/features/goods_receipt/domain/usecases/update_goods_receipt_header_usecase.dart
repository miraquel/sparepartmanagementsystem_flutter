import 'package:sparepartmanagementsystem_flutter/src/core/usecase/usecase.dart';
import 'package:sparepartmanagementsystem_flutter/src/core/resources/data_state.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/data/model/goods_receipt_header_model.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/domain/repositories/goods_receipt_repository.dart';

class UpdateGoodsReceiptHeaderUsecase implements UseCase<DataState<String>, GoodsReceiptHeaderModel> {
  final GoodsReceiptRepository repository;

  UpdateGoodsReceiptHeaderUsecase(this.repository);

  @override
  Future<DataState<String>> call({GoodsReceiptHeaderModel? params}) async {
    return await repository.updateGoodsReceiptHeader(params!);
  }
}
