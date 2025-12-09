import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/Model/operation_template_verificator_dto.dart';

part 'operation_template_verificator_filter_provider.g.dart';

@riverpod
class OperationTemplateVerificatorFilter extends _$OperationTemplateVerificatorFilter {
  @override
  OperationTemplateVerificatorDto build() {
    return OperationTemplateVerificatorDto();
  }

  void setFilter(OperationTemplateVerificatorDto filter) {
    state = filter;
  }

  void clearFilter() {
    state = OperationTemplateVerificatorDto();
  }
}
