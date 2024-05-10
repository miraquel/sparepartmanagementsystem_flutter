import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';

import 'package:sparepartmanagementsystem_flutter/Model/user_warehouse_dto.dart';

import '../../service_locator_setup.dart';
import '../Abstract/user_warehouse_dal.dart';

class UserWarehouseDALImplementation extends UserWarehouseDAL {
  final Dio _dio = locator<Dio>();

  @override
  Future<ApiResponseDto> addUserWarehouse(UserWarehouseDto userWarehouse) async {
    var result = await _dio.post(ApiPath.addUserWarehouse, data: userWarehouse);
    return ApiResponseDto.fromJson(result.data);
  }

  @override
  Future<ApiResponseDto> deleteUserWarehouse(int id) async {
    var result = await _dio.delete("${ApiPath.deleteUserWarehouse}/$id");
    return ApiResponseDto.fromJson(result.data);
  }

  @override
  Future<ApiResponseDto<List<UserWarehouseDto>>> getAllUserWarehouse() async {
    var result = await _dio.get(ApiPath.getAllUserWarehouse);
    return ApiResponseDto<List<UserWarehouseDto>>.fromJson(result.data, (json) => json.map<UserWarehouseDto>((e) => UserWarehouseDto.fromJson(e)).toList());
  }

  @override
  Future<ApiResponseDto<UserWarehouseDto>> getUserWarehouseById(int id) async {
    var result = await _dio.get("${ApiPath.getUserWarehouseById}/$id");
    return ApiResponseDto<UserWarehouseDto>.fromJson(result.data, (json) => UserWarehouseDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<List<UserWarehouseDto>>> getUserWarehouseByParams(UserWarehouseDto entity) async {
    var result = await _dio.post(ApiPath.getUserWarehouseByParams, data: entity);
    return ApiResponseDto<List<UserWarehouseDto>>.fromJson(result.data, (json) => json.map<UserWarehouseDto>((e) => UserWarehouseDto.fromJson(e)).toList());
  }

  @override
  Future<ApiResponseDto<List<UserWarehouseDto>>> getUserWarehouseByUserId(int id) async {
    var result = await _dio.get("${ApiPath.getUserWarehouseByUserId}/$id");
    return ApiResponseDto<List<UserWarehouseDto>>.fromJson(result.data, (json) => json.map<UserWarehouseDto>((e) => UserWarehouseDto.fromJson(e)).toList());
  }

  @override
  Future<ApiResponseDto> updateUserWarehouse(UserWarehouseDto userWarehouse) async {
    var result = await _dio.put(ApiPath.updateUserWarehouse, data: userWarehouse);
    return ApiResponseDto.fromJson(result.data);
  }

  @override
  Future<ApiResponseDto<UserWarehouseDto>> getDefaultUserWarehouseByUserId(int id) async {
    var result = await _dio.get("${ApiPath.getDefaultUserWarehouseByUserId}/$id");
    return ApiResponseDto<UserWarehouseDto>.fromJson(result.data, (json) => UserWarehouseDto.fromJson(json));
  }

}