import 'package:sparepartmanagementsystem_flutter/Model/row_level_access_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/constants/ax_table.dart';

class RowLevelAccessDtoBuilder {
  int _rowLevelAccessId = 0;
  int _userId = 0;
  AxTable _axTable = AxTable.none;
  String _query = '';
  bool _isSelected = false;

  RowLevelAccessDtoBuilder();

  int get rowLevelAccessId => _rowLevelAccessId;
  int get userId => _userId;
  AxTable get axTable => _axTable;
  String get query => _query;
  bool get isSelected => _isSelected;

  factory RowLevelAccessDtoBuilder.fromDto(RowLevelAccessDto rowLevelAccessDto) {
    return RowLevelAccessDtoBuilder()
      .setRowLevelAccessId(rowLevelAccessDto.rowLevelAccessId)
      .setUserId(rowLevelAccessDto.userId)
      .setAxTable(rowLevelAccessDto.axTable)
      .setQuery(rowLevelAccessDto.query);
  }

  RowLevelAccessDto build() {
    return RowLevelAccessDto(
      rowLevelAccessId: _rowLevelAccessId,
      userId: _userId,
      axTable: _axTable,
      query: _query,
    );
  }

  RowLevelAccessDtoBuilder setRowLevelAccessId(int rowLevelAccessId) {
    _rowLevelAccessId = rowLevelAccessId;
    return this;
  }

  RowLevelAccessDtoBuilder setUserId(int userId) {
    _userId = userId;
    return this;
  }

  RowLevelAccessDtoBuilder setAxTable(AxTable axTable) {
    _axTable = axTable;
    return this;
  }

  RowLevelAccessDtoBuilder setQuery(String query) {
    _query = query;
    return this;
  }

  RowLevelAccessDtoBuilder setIsSelected(bool isSelected) {
    _isSelected = isSelected;
    return this;
  }
}