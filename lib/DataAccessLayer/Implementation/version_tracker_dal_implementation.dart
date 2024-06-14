import 'package:dio/dio.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/version_tracker_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/version_tracker.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class VersionTrackerDALImplementation implements VersionTrackerDAL {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto> addVersionTracker(VersionTrackerDto versionTrackerDto) async {
    final response = await _dio.post(ApiPath.addVersionTracker, data: versionTrackerDto);
    return ApiResponseDto.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<ApiResponseDto> deleteVersionTracker(int id) async {
    final response = await _dio.delete('${ApiPath.deleteVersionTracker}/$id');
    return ApiResponseDto.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<ApiResponseDto<List<VersionTrackerDto>>> getAllVersionTracker() async {
    final response = await _dio.get(ApiPath.getAllVersionTracker);
    return ApiResponseDto<List<VersionTrackerDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => json.map<VersionTrackerDto>((e) => VersionTrackerDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto<VersionTrackerDto>> getVersionTrackerById(int id) async {
    final response = await _dio.get('${ApiPath.getVersionTrackerById}/$id');
    return ApiResponseDto<VersionTrackerDto>.fromJson(response.data as Map<String, dynamic>, (json) => VersionTrackerDto.fromJson(json));
  }

  @override
  Future<ApiResponseDto<List<VersionTrackerDto>>> getVersionTrackerByParams(VersionTrackerDto versionTrackerDto) async {
    final response = await _dio.get(ApiPath.getVersionTrackerByParams, queryParameters: versionTrackerDto.toJson());
    return ApiResponseDto<List<VersionTrackerDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => json.map<VersionTrackerDto>((e) => VersionTrackerDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto> updateVersionTracker(VersionTrackerDto versionTrackerDto) async {
    final response = await _dio.put(ApiPath.updateVersionTracker, data: versionTrackerDto);
    return ApiResponseDto.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<ApiResponseDto<VersionTrackerDto>> getLatestVersionTracker() async {
    final response = await _dio.get(ApiPath.getLatestVersionTracker);
    return ApiResponseDto<VersionTrackerDto>.fromJson(response.data as Map<String, dynamic>, (json) => VersionTrackerDto.fromJson(json));
  }

}