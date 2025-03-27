import 'package:sparepartmanagementsystem_flutter/src/core/usecase/usecase.dart';
import 'package:sparepartmanagementsystem_flutter/src/core/resources/data_state.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/data/model/goods_receipt_header_model.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/domain/repositories/goods_receipt_repository.dart';

class GetGoodsReceiptHeaderUsecase implements UseCase<DataState<List<GoodsReceiptHeaderModel>>, void> {
  final GoodsReceiptRepository repository;

  GetGoodsReceiptHeaderUsecase(this.repository);

  @override
  Future<DataState<List<GoodsReceiptHeaderModel>>> call({void params}) async {
    return await repository.getGoodsReceiptHeader();
  }
}