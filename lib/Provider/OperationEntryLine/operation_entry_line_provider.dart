import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/operation_entry_line_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_entry_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

part 'operation_entry_line_provider.g.dart';

@riverpod
class OperationEntryLine extends _$OperationEntryLine {
  @override
  Future<List<OperationEntryLineDto>> build(int operationEntryHeaderId) async {
    final operationEntryLineDal = locator<OperationEntryLineDal>();
    var operationEntryLines = <OperationEntryLineDto>[];

    final response = await operationEntryLineDal.getAll(operationEntryHeaderId);

    if (response.success) {
      operationEntryLines = response.data ?? [];
    } else {
      throw Exception(response.errorMessages);
    }

    operationEntryLines.sort((a, b) => a.operationEntryLineId.compareTo(b.operationEntryLineId));
    return operationEntryLines;
  }

  Future<void> updateOperationEntryLine(List<OperationEntryLineDto> dto) async {
    final operationEntryLineDal = locator<OperationEntryLineDal>();
    final response = await operationEntryLineDal.update(dto);

    if (response.success && response.data != null) {
      var currentData = await future;
      for (var item in response.data!) {
        final index = currentData.indexWhere((e) => e.operationEntryLineId == item.operationEntryLineId);
        if (index != -1) {
          currentData[index] = item;
        } else {
          currentData.add(item);
        }

        ref.notifyListeners();
      }
    } else {
      state = AsyncError(response.errorMessages.first.isNotEmpty
          ? response.errorMessages.first
          : response.message, StackTrace.current);
    }
  }
}
