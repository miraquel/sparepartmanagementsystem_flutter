import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_column_dto.dart';

part 'operation_template_column_filter_provider.g.dart';

@riverpod
class OperationTemplateColumnFilter extends _$OperationTemplateColumnFilter {
  @override
  OperationTemplateColumnDto build() {
    return OperationTemplateColumnDto();
  }

  void setFilter(OperationTemplateColumnDto filter) {
    state = filter;
  }

  void clearFilter() {
    state = OperationTemplateColumnDto();
  }
}
