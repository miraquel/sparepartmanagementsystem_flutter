import 'package:sparepartmanagementsystem_flutter/src/core/usecase/usecase.dart';
import 'package:sparepartmanagementsystem_flutter/src/core/resources/data_state.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/data/model/goods_receipt_header_model.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/domain/repositories/goods_receipt_repository.dart';

class GetGoodsReceiptHeaderByIdUsecase implements UseCase<DataState<GoodsReceiptHeaderModel>, int> {
  final GoodsReceiptRepository repository;

  GetGoodsReceiptHeaderByIdUsecase(this.repository);

  @override
  Future<DataState<GoodsReceiptHeaderModel>> call({int? params}) async {
    return await repository.getGoodsReceiptHeaderById(params!);
  }
}
