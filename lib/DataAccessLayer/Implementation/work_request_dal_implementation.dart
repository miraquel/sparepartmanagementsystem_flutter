
import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_request_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/eam_condition_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/eam_task_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_request_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_request_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class WorkRequestDalImplementation implements WorkRequestDal {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto<PagedListDto<WorkRequestDto>>> getWorkRequestPagedList(PagedListRequestDto dto) async {
    final response = await _dio.get(
      ApiPath.getWorkRequestPagedList,
      queryParameters: dto.toJson()
    );

    return ApiResponseDto<PagedListDto<WorkRequestDto>>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => PagedListDto<WorkRequestDto>.fromJson(
        json as Map<String, dynamic>,
        (json) => json.map<WorkRequestDto>((e) => WorkRequestDto.fromJson(e as Map<String, dynamic>)).toList(),
      ),
    );
  }

  @override
  Future<ApiResponseDto<WorkRequestDto>> getWorkRequest(String agsEamWrId) async {
    final response = await _dio.get(
      ApiPath.getWorkRequest,
      queryParameters: {'agsEamWrId': agsEamWrId}
    );

    return ApiResponseDto<WorkRequestDto>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => WorkRequestDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto> updateAcceptedWorkRequest(WorkRequestDto dto) async {
    final response = await _dio.post(
      ApiPath.updateAcceptedWorkRequest,
      data: dto.toJson()
    );

    return ApiResponseDto.fromJson(response.data);
  }

  @override
  Future<ApiResponseDto> createWorkOrderTable(WorkRequestDto dto) async {
    final response = await _dio.post(
      ApiPath.createWorkOrderTable,
      data: dto.toJson()
    );

    return ApiResponseDto.fromJson(response.data);
  }

  @override
  Future<ApiResponseDto<List<EamConditionDto>>> getConditionList(String search) async {
    final response = await _dio.get(
      ApiPath.getConditionList,
      queryParameters: {'search': search}
    );

    return ApiResponseDto<List<EamConditionDto>>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => json.map<EamConditionDto>((e) => EamConditionDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<ApiResponseDto<List<EamTaskDto>>> getTaskList(String search) {
    return _dio.get(
      ApiPath.getTaskList,
      queryParameters: {'search': search}
    ).then((response) {
      return ApiResponseDto<List<EamTaskDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => json.map<EamTaskDto>((e) => EamTaskDto.fromJson(e as Map<String, dynamic>)).toList(),
      );
    });
  }

  @override
  Future<ApiResponseDto> updateWorkRequest(WorkRequestDto dto) async {
    final response = await _dio.post(
      ApiPath.updateWorkRequest,
      data: dto.toJson()
    );

    return ApiResponseDto.fromJson(response.data);
  }

  @override
  Future<ApiResponseDto<bool>> validateWrkCtrId(String wrkCtrId) async {
    final response = await _dio.get(
      ApiPath.validateWrkCtrId,
      queryParameters: {'wrkCtrId': wrkCtrId}
    );

    return ApiResponseDto<bool>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => json as bool,
    );
  }

}