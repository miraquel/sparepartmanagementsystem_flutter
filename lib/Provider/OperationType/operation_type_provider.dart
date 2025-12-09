import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_type_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_type_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/OperationType/operation_type_filter_provider.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

part 'operation_type_provider.g.dart';

@riverpod
class OperationType extends _$OperationType {
  @override
  Future<List<OperationTypeDto>> build() async {
    final operationTypeDal = locator<OperationTypeDal>();
    var operationTypes = <OperationTypeDto>[];

    var filters = ref.watch(operationTypeFilterProvider);

    if (filters != OperationTypeDto()) {
      final response = await operationTypeDal.getByParams(filters);
      if (response.success) {
        operationTypes = response.data ?? [];
      } else {
        throw Exception(response.errorMessages);
      }
    } else {
      // If no filter is applied, get all operation types
      final response = await operationTypeDal.getAll();
      if (response.success) {
        operationTypes = response.data ?? [];
      } else {
        throw Exception(response.errorMessages);
      }
    }

    operationTypes.sort((a, b) => b.operationTypeId!.compareTo(a.operationTypeId!));
    return operationTypes;
  }

  // get operation type by id
  Future<void> getOperationTypeById(int id) async {
    var currentData = await future;
    final index = currentData.indexWhere((item) => item.operationTypeId == id);
    if (index == -1) {
      return;
    }

    final operationTypeDal = locator<OperationTypeDal>();
    final response = await operationTypeDal.getById(id);

    if (response.success && response.data != null) {
      currentData[index] = response.data!;
    } else {
      state = AsyncError(response.errorMessages.first.isNotEmpty
          ? response.errorMessages.first
          : response.message, StackTrace.current);
    }

    ref.notifyListeners();
  }

  // add operation type
  Future<OperationTypeDto> addOperationType(OperationTypeDto dto) async {
    final operationTypeDal = locator<OperationTypeDal>();
    final response = await operationTypeDal.add(dto);

    if (response.success && response.data != null) {
      var previousState = await future;
      state = AsyncData([response.data!, ...previousState]);
      var operationTypeDto = dto.copyWith(
        operationTypeId: response.data!.operationTypeId,
        name: response.data!.name,
        description: response.data!.description,
        createdBy: response.data!.createdBy,
        createdDateTime: response.data!.createdDateTime,
        modifiedBy: response.data!.modifiedBy,
        modifiedDateTime: response.data!.modifiedDateTime,
      );
      return operationTypeDto;
    } else {
      //state = AsyncError(response.errorMessages.first.isNotEmpty ? response.errorMessages.first : response.message, StackTrace.current);
      ref.read(snackbarMessageProvider.notifier).show(
        response.errorMessages.isNotEmpty ? response.errorMessages.first : response.message,
      );
    }

    return dto;
  }

  // update operation type, get the index of the updated item and replace it in the list
  Future<void> updateOperationType(OperationTypeDto dto) async {
    var currentData = state.valueOrNull ?? [];
    final index = currentData.indexWhere((item) => item.operationTypeId == dto.operationTypeId);
    if (index == -1) {
      state = AsyncError('Operation Type not found', StackTrace.current);
      return;
    }

    final operationTypeDal = locator<OperationTypeDal>();
    final response = await operationTypeDal.update(dto);

    if (response.success) {
      var updated = await operationTypeDal.getById(dto.operationTypeId!);
      currentData[index] = updated.data!;
    } else {
      state = AsyncError(response.errorMessages.first, StackTrace.current);
    }

    ref.notifyListeners();
  }

  // delete operation type
  Future<void> deleteOperationType(int id) async {
    state = const AsyncLoading();
    final operationTypeDal = locator<OperationTypeDal>();
    final response = await operationTypeDal.delete(id);

    if (response.success) {
      var currentData = state.valueOrNull ?? [];
      currentData.removeWhere((item) => item.operationTypeId == id);
      state = AsyncData(currentData);
    } else {
      state = AsyncError(response.errorMessages.first, StackTrace.current);
    }
  }
}