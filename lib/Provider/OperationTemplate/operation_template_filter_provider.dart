import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_dto.dart';

part 'operation_template_filter_provider.g.dart';

@riverpod
class OperationTemplateFilter extends _$OperationTemplateFilter {
  @override
  OperationTemplateDto build() {
    return OperationTemplateDto();
  }

  void setFilter(OperationTemplateDto filter) {
    state = filter;
  }

  void clearFilter() {
    state = OperationTemplateDto();
  }
}