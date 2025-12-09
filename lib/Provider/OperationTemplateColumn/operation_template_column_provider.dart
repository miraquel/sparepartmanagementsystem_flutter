import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_template_column_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_column_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationTemplateColumn/operation_template_column_filter_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

part 'operation_template_column_provider.g.dart';

@riverpod
class OperationTemplateColumn extends _$OperationTemplateColumn {
  @override
  Future<List<OperationTemplateColumnDto>> build(int operationTemplateId) async {
    final operationTemplateColumnDal = locator<OperationTemplateColumnDal>();
    var operationTemplateColumns = <OperationTemplateColumnDto>[];

    var filters = ref.watch(operationTemplateColumnFilterProvider);

    if (filters != OperationTemplateColumnDto()) {
      final response = await operationTemplateColumnDal.getByParams(operationTemplateId, filters);
      if (response.success) {
        operationTemplateColumns = response.data ?? [];
      } else {
        throw Exception(response.errorMessages);
      }
    } else {
      final response = await operationTemplateColumnDal.getAll(operationTemplateId);
      if (response.success) {
        operationTemplateColumns = response.data ?? [];
      } else {
        throw Exception(response.errorMessages);
      }
    }

    operationTemplateColumns.sort((a, b) => a.position!.compareTo(b.position!));
    return operationTemplateColumns;
  }

  Future<void> getOperationTemplateColumnById(int id) async {
    var currentData = await future;
    final index = currentData.indexWhere((item) => item.operationTemplateColumnId == id);
    if (index == -1) {
      return;
    }

    final operationTemplateColumnDal = locator<OperationTemplateColumnDal>();
    final response = await operationTemplateColumnDal.getById(id);

    if (response.success && response.data != null) {
      currentData[index] = response.data!;
    } else {
      state = AsyncError(response.errorMessages.first.isNotEmpty
          ? response.errorMessages.first
          : response.message, StackTrace.current);
    }

    ref.notifyListeners();
  }

  Future<OperationTemplateColumnDto> addOperationTemplateColumn(OperationTemplateColumnDto dto) async {
    final operationTemplateColumnDal = locator<OperationTemplateColumnDal>();
    final response = await operationTemplateColumnDal.add(dto);

    if (response.success && response.data != null) {
      var previousState = await future;
      var newData = [...previousState, response.data!];
      newData.sort((a, b) => a.position!.compareTo(b.position!));
      state = AsyncData(newData);
      ref.read(snackbarMessageProvider.notifier).show(response.message);
      return response.data!;
    } else {
      state = AsyncError(response.errorMessages.first.isNotEmpty
          ? response.errorMessages.first
          : response.message, StackTrace.current);
    }

    return response.data ?? dto;
  }

  Future<void> updateOperationTemplateColumn(OperationTemplateColumnDto dto) async {
    final operationTemplateColumnDal = locator<OperationTemplateColumnDal>();
    final response = await operationTemplateColumnDal.update(dto);

    if (response.success && response.data != null) {
      var currentData = await future;
      final index = currentData.indexWhere((item) => item.operationTemplateColumnId == dto.operationTemplateColumnId);
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

  Future<void> deleteOperationTemplateColumn(int operationTemplateColumnId) async {
    final operationTemplateColumnDal = locator<OperationTemplateColumnDal>();
    final response = await operationTemplateColumnDal.delete(operationTemplateColumnId);

    if (response.success) {
      var currentData = await future;
      currentData.removeWhere((item) => item.operationTemplateColumnId == operationTemplateColumnId);
      state = AsyncData(currentData);
      ref.read(snackbarMessageProvider.notifier).show(response.message);
    } else {
      ref.read(snackbarMessageProvider.notifier).show(
        response.errorMessages.isNotEmpty ? response.errorMessages.first : response.message,
      );
    }
  }
}