import 'package:equatable/equatable.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/domain/entity/goods_receipt_header_entity.dart';

abstract class RemoteGoodsReceiptEvent extends Equatable {
  final List<GoodsReceiptHeaderEntity>? goodsReceiptHeader;
  final GoodsReceiptHeaderEntity? goodsReceiptHeaderEntity;
  final DioError ? error;

  const RemoteArticlesState({this.articles,this.error});

  @override
  List<Object> get props => [articles!, error!];
}