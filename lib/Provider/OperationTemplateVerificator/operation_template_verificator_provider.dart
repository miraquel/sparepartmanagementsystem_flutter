import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_template_verificator_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_verificator_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationTemplateVerificator/operation_template_verificator_filter_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

part 'operation_template_verificator_provider.g.dart';

@riverpod
class OperationTemplateVerificator extends _$OperationTemplateVerificator {
  @override
  Future<List<OperationTemplateVerificatorDto>> build(int operationTemplateId) async {
    final operationTemplateVerificatorDal = locator<OperationTemplateVerificatorDal>();
    var operationTemplateVerificators = <OperationTemplateVerificatorDto>[];

    var filters = ref.watch(operationTemplateVerificatorFilterProvider);

    if (filters != OperationTemplateVerificatorDto()) {
      final response = await operationTemplateVerificatorDal.getByParams(operationTemplateId, filters);
      if (response.success) {
        operationTemplateVerificators = response.data ?? [];
      } else {
        throw Exception(response.errorMessages);
      }
    } else {
      // If no filter is applied, get all operation templates
      final response = await operationTemplateVerificatorDal.getAll(operationTemplateId);
      if (response.success) {
        operationTemplateVerificators = response.data ?? [];
      } else {
        throw Exception(response.errorMessages);
      }
    }

    return operationTemplateVerificators;
  }

  Future<void> getOperationTemplateVerificatorById(int id) async {
    var currentData = await future;
    final index = currentData.indexWhere((item) => item.operationTemplateVerificatorId == id);
    if (index == -1) {
      return;
    }

    final operationTemplateVerificatorDal = locator<OperationTemplateVerificatorDal>();
    final response = await operationTemplateVerificatorDal.getById(id);

    if (response.success && response.data != null) {
      currentData[index] = response.data!;
    } else {
      state = AsyncError(response.errorMessages.first.isNotEmpty
          ? response.errorMessages.first
          : response.message, StackTrace.current);
    }

    ref.notifyListeners();
  }

  Future<OperationTemplateVerificatorDto> addOperationTemplateVerificator(OperationTemplateVerificatorDto dto) async {
    final operationTemplateVerificatorDal = locator<OperationTemplateVerificatorDal>();
    final response = await operationTemplateVerificatorDal.add(dto);

    if (response.success && response.data != null) {
      var previousState = await future;
      var newData = [...previousState, response.data!];
      state = AsyncData(newData);
      ref.read(snackbarMessageProvider.notifier).show(response.message);
    } else {
      state = AsyncError(response.errorMessages.first.isNotEmpty
          ? response.errorMessages.first
          : response.message, StackTrace.current);
    }

    return response.data ?? dto;
  }

  Future<void> updateOperationTemplateVerificator(OperationTemplateVerificatorDto dto) async {
    final operationTemplateVerificatorDal = locator<OperationTemplateVerificatorDal>();
    final response = await operationTemplateVerificatorDal.update(dto);

    if (response.success && response.data != null) {
      var currentData = await future;
      final index = currentData.indexWhere((item) => item.operationTemplateVerificatorId == dto.operationTemplateVerificatorId);
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

  Future<void> deleteOperationTemplateVerificator(int id) async {
    final operationTemplateVerificatorDal = locator<OperationTemplateVerificatorDal>();
    final response = await operationTemplateVerificatorDal.delete(id);

    if (response.success) {
      var currentData = await future;
      currentData.removeWhere((item) => item.operationTemplateVerificatorId == id);
      state = AsyncData(currentData);
      ref.read(snackbarMessageProvider.notifier).show(response.message);
    } else {
      ref.read(snackbarMessageProvider.notifier).show(
        response.errorMessages.isNotEmpty ? response.errorMessages.first : response.message,
      );
    }
  }
}
