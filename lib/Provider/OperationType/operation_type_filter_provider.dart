import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_type_dto.dart';

part 'operation_type_filter_provider.g.dart';

@riverpod
class OperationTypeFilter extends _$OperationTypeFilter {
  @override
  OperationTypeDto build() {
    return OperationTypeDto();
  }

  Future<void> setFilter(OperationTypeDto dto) async {
    state = dto;
  }
}