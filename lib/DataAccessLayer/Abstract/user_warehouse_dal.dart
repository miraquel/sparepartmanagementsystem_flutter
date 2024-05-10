import '../../Model/api_response_dto.dart';
import '../../Model/user_warehouse_dto.dart';

abstract class UserWarehouseDAL {
  Future<ApiResponseDto<UserWarehouseDto>> getUserWarehouseById(int id);
  Future<ApiResponseDto<List<UserWarehouseDto>>> getAllUserWarehouse();
  Future<ApiResponseDto<List<UserWarehouseDto>>> getUserWarehouseByParams(UserWarehouseDto entity);
  Future<ApiResponseDto<List<UserWarehouseDto>>> getUserWarehouseByUserId(int id);
  Future<ApiResponseDto<UserWarehouseDto>> getDefaultUserWarehouseByUserId(int id);
  Future<ApiResponseDto> deleteUserWarehouse(int id);
  Future<ApiResponseDto> addUserWarehouse(UserWarehouseDto userWarehouse);
  Future<ApiResponseDto> updateUserWarehouse(UserWarehouseDto userWarehouse);
}