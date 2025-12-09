import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_entry_header_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_entry_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationEntryHeader/operation_entry_header_filter_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

part 'operation_entry_header_provider.g.dart';

@riverpod
class OperationEntryHeader extends _$OperationEntryHeader {
  @override
  Future<List<OperationEntryHeaderDto>> build() async {
    final operationEntryHeaderDal = locator<OperationEntryHeaderDal>();
    var operationTemplates = <OperationEntryHeaderDto>[];

    var filters = ref.watch(operationEntryHeaderFilterProvider);

    if (filters.isNotEmpty) {
      final response = await operationEntryHeaderDal.getByParams(filters);
      if (response.success) {
        operationTemplates = response.data ?? [];
      } else {
        throw Exception(response.errorMessages);
      }
    } else {
      // If no filter is applied, get all operation templates
      final response = await operationEntryHeaderDal.getAll();
      if (response.success) {
        operationTemplates = response.data ?? [];
      } else {
        throw Exception(response.errorMessages);
      }
    }

    operationTemplates.sort((a, b) => b.operationEntryHeaderId!.compareTo(a.operationEntryHeaderId!));
    return operationTemplates;
  }

  Future<void> getOperationEntryHeaderById(int id) async {
    var currentData = await future;
    final index = currentData.indexWhere((item) => item.operationEntryHeaderId == id);
    if (index == -1) {
      return;
    }

    final operationTemplateDal = locator<OperationEntryHeaderDal>();
    final response = await operationTemplateDal.getById(id);

    if (response.success && response.data != null) {
      currentData[index] = response.data!;
    } else {
      state = AsyncError(response.errorMessages.first.isNotEmpty
          ? response.errorMessages.first
          : response.message, StackTrace.current);
    }

    ref.notifyListeners();
  }

  Future<OperationEntryHeaderDto> addOperationEntryHeader(OperationEntryHeaderDto dto) async {
    final operationTemplateDal = locator<OperationEntryHeaderDal>();
    final response = await operationTemplateDal.add(dto);

    if (response.success && response.data != null) {
      var previousState = await future;
      state = AsyncData([response.data!, ...previousState]);
      return response.data!;
    } else {
      ref.read(snackbarMessageProvider.notifier).show(
        response.errorMessages.isNotEmpty ? response.errorMessages.first : response.message,
      );
    }

    return response.data ?? dto;
  }

  Future<void> updateOperationEntryHeader(OperationEntryHeaderDto dto) async {
    final operationTemplateDal = locator<OperationEntryHeaderDal>();
    final response = await operationTemplateDal.update(dto);

    if (response.success && response.data != null) {
      var currentData = await future;
      final index = currentData.indexWhere((item) => item.operationEntryHeaderId == dto.operationEntryHeaderId);
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

  Future<void> deleteOperationEntryHeader(int id) async {
    final operationTemplateDal = locator<OperationEntryHeaderDal>();
    final response = await operationTemplateDal.delete(id);

    if (response.success) {
      var currentData = await future;
      currentData.removeWhere((item) => item.operationEntryHeaderId == id);
      state = AsyncData(currentData);
      ref.read(snackbarMessageProvider.notifier).show(response.message);
    } else {
      ref.read(snackbarMessageProvider.notifier).show(
        response.errorMessages.isNotEmpty ? response.errorMessages.first : response.message,
      );
    }
  }
}
