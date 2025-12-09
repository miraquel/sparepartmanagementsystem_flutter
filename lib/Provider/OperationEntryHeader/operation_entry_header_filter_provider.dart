import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'operation_entry_header_filter_provider.g.dart';

@riverpod
class OperationEntryHeaderFilter extends _$OperationEntryHeaderFilter {
  @override
  Map<String, dynamic> build() {
    return {};
  }

  void setFilter(Map<String, dynamic> filter) {
    state = filter;
  }

  void clearFilter() {
    state = {};
  }
}
