import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_template_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationTemplate/operation_template_filter_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

part 'operation_template_provider.g.dart';

@riverpod
class OperationTemplate extends _$OperationTemplate {
  @override
  Future<List<OperationTemplateDto>> build() async {
    final operationTemplateDal = locator<OperationTemplateDal>();
    var operationTemplates = <OperationTemplateDto>[];

    var filters = ref.watch(operationTemplateFilterProvider);

    if (filters != OperationTemplateDto()) {
      final response = await operationTemplateDal.getByParams(filters);
      if (response.success) {
        operationTemplates = response.data ?? [];
      } else {
        throw Exception(response.errorMessages);
      }
    } else {
      // If no filter is applied, get all operation templates
      final response = await operationTemplateDal.getAll();
      if (response.success) {
        operationTemplates = response.data ?? [];
      } else {
        throw Exception(response.errorMessages);
      }
    }

    operationTemplates.sort((a, b) => b.operationTemplateId!.compareTo(a.operationTemplateId!));
    return operationTemplates;
  }

  // get operation template by id
  Future<void> getOperationTemplateById(int id) async {
    var currentData = await future;
    final index = currentData.indexWhere((item) => item.operationTemplateId == id);
    if (index == -1) {
      return;
    }

    final operationTemplateDal = locator<OperationTemplateDal>();
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

  Future<OperationTemplateDto> addOperationTemplate(OperationTemplateDto dto) async {
    final operationTemplateDal = locator<OperationTemplateDal>();
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

  Future<void> updateOperationTemplate(OperationTemplateDto dto) async {
    final operationTemplateDal = locator<OperationTemplateDal>();
    final response = await operationTemplateDal.update(dto);

    if (response.success && response.data != null) {
      var currentData = await future;
      final index = currentData.indexWhere((item) => item.operationTemplateId == dto.operationTemplateId);
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

  Future<void> deleteOperationTemplate(int id) async {
    final operationTemplateDal = locator<OperationTemplateDal>();
    final response = await operationTemplateDal.delete(id);

    if (response.success) {
      var currentData = await future;
      currentData.removeWhere((item) => item.operationTemplateId == id);
      state = AsyncData(currentData);
      ref.read(snackbarMessageProvider.notifier).show(response.message);
    } else {
      ref.read(snackbarMessageProvider.notifier).show(
        response.errorMessages.isNotEmpty ? response.errorMessages.first : response.message,
      );
    }
  }
}