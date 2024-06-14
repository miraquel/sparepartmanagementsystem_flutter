import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/version_tracker.dart';

abstract class VersionTrackerDAL {
  Future<ApiResponseDto<List<VersionTrackerDto>>> getAllVersionTracker();
  Future<ApiResponseDto<VersionTrackerDto>> getVersionTrackerById(int id);
  Future<ApiResponseDto> deleteVersionTracker(int id);
  Future<ApiResponseDto> addVersionTracker(VersionTrackerDto versionTrackerDto);
  Future<ApiResponseDto> updateVersionTracker(VersionTrackerDto versionTrackerDto);
  Future<ApiResponseDto<List<VersionTrackerDto>>> getVersionTrackerByParams(VersionTrackerDto versionTrackerDto);
  Future<ApiResponseDto<VersionTrackerDto>> getLatestVersionTracker();
}