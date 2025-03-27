import 'package:sparepartmanagementsystem_flutter/src/core/usecase/usecase.dart';
import 'package:sparepartmanagementsystem_flutter/src/core/resources/data_state.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/data/model/goods_receipt_header_model.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/domain/repositories/goods_receipt_repository.dart';
import 'package:sparepartmanagementsystem_flutter/src/shared/model/paged_list.dart';

class GetGoodsReceiptHeaderByParamsPagedListParams {
  final int pageNumber;
  final int pageSize;
  final GoodsReceiptHeaderModel dto;

  GetGoodsReceiptHeaderByParamsPagedListParams({
    required this.pageNumber,
    required this.pageSize,
    required this.dto,
  });
}

class GetGoodsReceiptHeaderByParamsPagedListUsecase implements UseCase<DataState<PagedList<GoodsReceiptHeaderModel>>, GetGoodsReceiptHeaderByParamsPagedListParams> {
  final GoodsReceiptRepository repository;

  GetGoodsReceiptHeaderByParamsPagedListUsecase(this.repository);

  @override
  Future<DataState<PagedList<GoodsReceiptHeaderModel>>> call({GetGoodsReceiptHeaderByParamsPagedListParams? params}) async {
    return await repository.getGoodsReceiptHeaderByParamsPagedList(
      params!.pageNumber,
      params.pageSize,
      params.dto,
    );
  }
}
