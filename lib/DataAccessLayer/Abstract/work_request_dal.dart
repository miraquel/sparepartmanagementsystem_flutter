import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/eam_condition_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/eam_task_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_request_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_request_dto.dart';

abstract class WorkRequestDal {
  Future<ApiResponseDto<PagedListDto<WorkRequestDto>>> getWorkRequestPagedList(PagedListRequestDto dto);
  Future<ApiResponseDto<WorkRequestDto>> getWorkRequest(String agsEamWrId);
  Future<ApiResponseDto> updateAcceptedWorkRequest(WorkRequestDto dto);
  Future<ApiResponseDto> createWorkOrderTable(WorkRequestDto dto);
  Future<ApiResponseDto<List<EamConditionDto>>> getConditionList(String search);
  Future<ApiResponseDto<List<EamTaskDto>>> getTaskList(String search);
  Future<ApiResponseDto> updateWorkRequest(WorkRequestDto dto);
  Future<ApiResponseDto<bool>> validateWrkCtrId(String wrkCtrId);
}