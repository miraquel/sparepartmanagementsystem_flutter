

import '../../Model/api_response_dto.dart';
import '../../Model/row_level_access_dto.dart';

abstract class RowLevelAccessDAL {
  Future<ApiResponseDto<List<RowLevelAccessDto>>> getRowLevelAccess();
  Future<ApiResponseDto> deleteRowLevelAccess(int rowLevelAccessId);
  Future<ApiResponseDto> addRowLevelAccess(RowLevelAccessDto rowLevelAccess);
  Future<ApiResponseDto<RowLevelAccessDto>> getRowLevelAccessById(int rowLevelAccessId);
  Future<ApiResponseDto<List<RowLevelAccessDto>>> getRowLevelAccessByParams(RowLevelAccessDto dto);
  Future<ApiResponseDto> updateRowLevelAccess(RowLevelAccessDto rowLevelAccess);
  Future<ApiResponseDto<List<RowLevelAccessDto>>> getRowLevelAccessByUserId(int userId);
  Future<ApiResponseDto> bulkDeleteRowLevelAccess(List<int> rowLevelAccessIds);
}