import 'package:sparepartmanagementsystem_flutter/src/core/usecase/usecase.dart';
import 'package:sparepartmanagementsystem_flutter/src/core/resources/data_state.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/domain/repositories/goods_receipt_repository.dart';

class DeleteGoodsReceiptHeaderUsecase implements UseCase<DataState<String>, int> {
  final GoodsReceiptRepository repository;

  DeleteGoodsReceiptHeaderUsecase(this.repository);

  @override
  Future<DataState<String>> call({int? params}) async {
    return await repository.deleteGoodsReceiptHeader(params!);
  }
}
