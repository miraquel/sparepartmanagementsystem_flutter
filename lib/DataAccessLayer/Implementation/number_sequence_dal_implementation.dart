import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/number_sequence_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/number_sequence_dal.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';

const storage = FlutterSecureStorage();

class NumberSequenceDALImplementation implements NumberSequenceDAL {
  final _dio = locator<Dio>();

  @override
  Future<ApiResponseDto> addNumberSequence(NumberSequenceDto numberSequence) async {
    final response = await _dio.post(ApiPath.addNumberSequence, data: numberSequence);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto> deleteNumberSequence(int numberSequenceId) async {    const path = ApiPath.deleteNumberSequence;
    final response = await _dio.delete("$path/$numberSequenceId");
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }

  @override
  Future<ApiResponseDto<List<NumberSequenceDto>>> getAllNumberSequence() async {
    final response = await _dio.get(ApiPath.getAllNumberSequence);

    return ApiResponseDto<List<NumberSequenceDto>>.fromJson(response.data as Map<String, dynamic>,
        (json) => json.map<NumberSequenceDto>((e) => NumberSequenceDto.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<ApiResponseDto<NumberSequenceDto>> getNumberSequenceById(int numberSequenceId) async {
    final response = await _dio.get('${ApiPath.getNumberSequenceById}/$numberSequenceId');
    return ApiResponseDto<NumberSequenceDto>.fromJson(response.data as Map<String, dynamic>, (json) => NumberSequenceDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto> updateNumberSequence(NumberSequenceDto numberSequence) async {
    final response = await _dio.put(
      ApiPath.updateNumberSequence,
      data: numberSequence,
    );
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto.fromJson(responseBody);
  }
}
