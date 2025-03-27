import 'package:sparepartmanagementsystem_flutter/src/core/usecase/usecase.dart';
import 'package:sparepartmanagementsystem_flutter/src/core/resources/data_state.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/data/model/goods_receipt_header_model.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/domain/repositories/goods_receipt_repository.dart';
import 'package:sparepartmanagementsystem_flutter/src/shared/model/paged_list.dart';

class GetGoodsReceiptHeaderPagedListParams {
  final int pageNumber;
  final int pageSize;

  GetGoodsReceiptHeaderPagedListParams({
    required this.pageNumber,
    required this.pageSize,
  });
}

class GetGoodsReceiptHeaderPagedListUsecase implements UseCase<DataState<PagedList<GoodsReceiptHeaderModel>>, GetGoodsReceiptHeaderPagedListParams> {
  final GoodsReceiptRepository repository;

  GetGoodsReceiptHeaderPagedListUsecase(this.repository);

  @override
  Future<DataState<PagedList<GoodsReceiptHeaderModel>>> call({GetGoodsReceiptHeaderPagedListParams? params}) async {
    return await repository.getGoodsReceiptHeaderPagedList(
      params!.pageNumber,
      params.pageSize,
    );
  }
}
