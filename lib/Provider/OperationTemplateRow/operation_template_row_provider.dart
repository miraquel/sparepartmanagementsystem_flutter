import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_template_row_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_row_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

import 'operation_template_row_filter_provider.dart';

part 'operation_template_row_provider.g.dart';

@riverpod
class OperationTemplateRow extends _$OperationTemplateRow {
  @override
  Future<List<OperationTemplateRowDto>> build(int operationTemplateId) async {
    final operationTemplateRowDal = locator<OperationTemplateRowDal>();
    var operationTemplateColumns = <OperationTemplateRowDto>[];

    var filters = ref.watch(operationTemplateRowFilterProvider);

    if (filters != OperationTemplateRowDto()) {
      final response = await operationTemplateRowDal.getByParams(operationTemplateId, filters);
      if (response.success) {
        operationTemplateColumns = response.data ?? [];
      } else {
        throw Exception(response.errorMessages);
      }
    } else {
      final response = await operationTemplateRowDal.getAll(operationTemplateId);
      if (response.success) {
        operationTemplateColumns = response.data ?? [];
      } else {
        throw Exception(response.errorMessages);
      }
    }

    operationTemplateColumns.sort((a, b) => a.position!.compareTo(b.position!));
    return operationTemplateColumns;
  }

  Future<void> getOperationTemplateRowById(int id) async {
    var currentData = await future;
    final index = currentData.indexWhere((item) => item.operationTemplateRowId == id);
    if (index == -1) {
      return;
    }

    final operationTemplateRowDal = locator<OperationTemplateRowDal>();
    final response = await operationTemplateRowDal.getById(id);

    if (response.success && response.data != null) {
      currentData[index] = response.data!;
    } else {
      state = AsyncError(response.errorMessages.first.isNotEmpty
          ? response.errorMessages.first
          : response.message, StackTrace.current);
    }

    ref.notifyListeners();
  }

  Future<OperationTemplateRowDto> addOperationTemplateRow(OperationTemplateRowDto dto) async {
    final operationTemplateRowDal = locator<OperationTemplateRowDal>();
    final response = await operationTemplateRowDal.add(dto);

    if (response.success && response.data != null) {
      var previousState = await future;
      var newData = [...previousState, response.data!];
      newData.sort((a, b) => a.position!.compareTo(b.position!));
      state = AsyncData(newData);
      ref.read(snackbarMessageProvider.notifier).show(response.message);
    } else {
      state = AsyncError(response.errorMessages.first.isNotEmpty
          ? response.errorMessages.first
          : response.message, StackTrace.current);
    }

    return response.data ?? dto;
  }

  Future<void> updateOperationTemplateRow(OperationTemplateRowDto dto) async {
    final operationTemplateRowDal = locator<OperationTemplateRowDal>();
    final response = await operationTemplateRowDal.update(dto);

    if (response.success && response.data != null) {
      var currentData = await future;
      final index = currentData.indexWhere((item) => item.operationTemplateRowId == dto.operationTemplateRowId);
      if (index != -1) {
        currentData[index] = response.data!;
        ref.read(snackbarMessageProvider.notifier).show(response.message);
      }
    } else {
      state = AsyncError(response.errorMessages.first.isNotEmpty
          ? response.errorMessages.first
          : response.message, StackTrace.current);
    }

    ref.notifyListeners();
  }

  Future<void> deleteOperationTemplateRow(int id) async {
    final operationTemplateRowDal = locator<OperationTemplateRowDal>();
    final response = await operationTemplateRowDal.delete(id);

    if (response.success) {
      var currentData = await future;
      currentData.removeWhere((item) => item.operationTemplateRowId == id);
      state = AsyncData(currentData);
      ref.read(snackbarMessageProvider.notifier).show(response.message);
    } else {
      ref.read(snackbarMessageProvider.notifier).show(
        response.errorMessages.isNotEmpty ? response.errorMessages.first : response.message,
      );
    }
  }
}