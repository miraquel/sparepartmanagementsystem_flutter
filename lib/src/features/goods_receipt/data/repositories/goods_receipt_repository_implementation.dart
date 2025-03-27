import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/src/core/resources/data_state.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/data/data_source/remote/goods_receipt_service.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/data/model/goods_receipt_header_model.dart';
import 'package:sparepartmanagementsystem_flutter/src/features/goods_receipt/domain/repositories/goods_receipt_repository.dart';
import 'package:sparepartmanagementsystem_flutter/src/shared/model/paged_list.dart';

class GoodsReceiptRepositoryImplementation implements GoodsReceiptRepository {
  final GoodsReceiptService _goodsReceiptService;

  GoodsReceiptRepositoryImplementation(this._goodsReceiptService);

  @override
  Future<DataState<GoodsReceiptHeaderModel>> addAndReturnGoodsReceiptHeaderWithLines(GoodsReceiptHeaderModel goodsReceiptHeader) async {
    try {
      final httpResponse = await _goodsReceiptService.addAndReturnGoodsReceiptHeaderWithLines(goodsReceiptHeader);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return httpResponse.data.data != null ?
        DataSuccess(httpResponse.data.data!) :
        DataFailed(
            DioException(
                error: 'No data found',
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      } else {
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> addGoodsReceiptHeader(GoodsReceiptHeaderModel goodsReceiptHeader) async {
    try {
      var httpResponse = await _goodsReceiptService.addGoodsReceiptHeader(goodsReceiptHeader);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> addGoodsReceiptHeaderWithLines(GoodsReceiptHeaderModel goodsReceiptHeader) async {
    try {
      var httpResponse = await _goodsReceiptService.addGoodsReceiptHeaderWithLines(goodsReceiptHeader);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> deleteGoodsReceiptHeader(int goodsReceiptHeaderId) async {
    try {
      var httpResponse = await _goodsReceiptService.deleteGoodsReceiptHeader(goodsReceiptHeaderId);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<GoodsReceiptHeaderModel>>> getGoodsReceiptHeader() async {
    try {
      final httpResponse = await _goodsReceiptService.getGoodsReceiptHeader();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return httpResponse.data.data != null ?
        DataSuccess(httpResponse.data.data!) :
        DataFailed(
            DioException(
                error: 'No data found',
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      } else {
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<GoodsReceiptHeaderModel>> getGoodsReceiptHeaderById(int goodsReceiptHeaderId) async {
    try {
      var httpResponse = await _goodsReceiptService.getGoodsReceiptHeaderById(goodsReceiptHeaderId);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return httpResponse.data.data != null ?
        DataSuccess(httpResponse.data.data!) :
        DataFailed(
            DioException(
                error: 'No data found',
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      } else {
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<GoodsReceiptHeaderModel>> getGoodsReceiptHeaderByIdWithLines(int goodsReceiptHeaderId) async {
    try {
      final httpResponse = await _goodsReceiptService.getGoodsReceiptHeaderByIdWithLines(goodsReceiptHeaderId);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return httpResponse.data.data != null ?
          DataSuccess(httpResponse.data.data!) :
          DataFailed(
            DioException(
              error: 'No data found',
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions
            )
          );
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<PagedList<GoodsReceiptHeaderModel>>> getGoodsReceiptHeaderByParamsPagedList(int pageNumber, int pageSize, GoodsReceiptHeaderModel dto) async {
    try {
      final httpResponse = await _goodsReceiptService.getGoodsReceiptHeaderByParamsPagedList(pageNumber, pageSize, dto);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return httpResponse.data.data != null ?
        DataSuccess(httpResponse.data.data!) :
        DataFailed(
            DioException(
                error: 'No data found',
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      } else {
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<PagedList<GoodsReceiptHeaderModel>>> getGoodsReceiptHeaderPagedList(int pageNumber, int pageSize) async {
    try {
      final httpResponse = await _goodsReceiptService.getGoodsReceiptHeaderPagedList(pageNumber, pageSize);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return httpResponse.data.data != null ?
        DataSuccess(httpResponse.data.data!) :
        DataFailed(
            DioException(
                error: 'No data found',
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      } else {
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> getGoodsReceiptLabelTemplate(GoodsReceiptHeaderModel model, int copies) async {
    try {
      var httpResponse = await _goodsReceiptService.getGoodsReceiptLabelTemplate(model, copies);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if (httpResponse.data.data != null) {
          return DataSuccess(httpResponse.data.data!);
        } else {
          return DataFailed(
            DioException(
              error: 'No data found',
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions
            )
          );
        }
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> postToAX(GoodsReceiptHeaderModel goodsReceiptHeader) async {
    try {
      var httpResponse = await _goodsReceiptService.postToAX(goodsReceiptHeader);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> updateGoodsReceiptHeader(GoodsReceiptHeaderModel goodsReceiptHeader) async {
    try {
      var httpResponse = await _goodsReceiptService.updateGoodsReceiptHeader(goodsReceiptHeader);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> updateGoodsReceiptHeaderWithLines(GoodsReceiptHeaderModel goodsReceiptHeader) async {
    try {
      var httpResponse = await _goodsReceiptService.updateGoodsReceiptHeaderWithLines(goodsReceiptHeader);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

}