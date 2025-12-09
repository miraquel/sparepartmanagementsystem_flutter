import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_row_dto.dart';

part 'operation_template_row_filter_provider.g.dart';

@riverpod
class OperationTemplateRowFilter extends _$OperationTemplateRowFilter {
  @override
  OperationTemplateRowDto build() {
    return OperationTemplateRowDto();
  }

  void setFilter(OperationTemplateRowDto filter) {
    state = filter;
  }

  void clearFilter() {
    state = OperationTemplateRowDto();
  }
}