import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../Model/api_response_dto.dart';
import '../../Model/number_sequence_dto.dart';
import '../../service_locator_setup.dart';
import '../Abstract/number_sequence_dal.dart';
import '../api_path.dart';

const storage = FlutterSecureStorage();

class NumberSequenceDALImplementation implements NumberSequenceDAL {
  Future<Dio> loadDio() async => await locator.getAsync<Dio>();

  @override
  Future<ApiResponseDto<NumberSequenceDto>> addNumberSequence(NumberSequenceDto numberSequence) async {
    final dio = await loadDio();
    final response = await dio.post(ApiPath.addNumberSequence, data: numberSequence);
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<NumberSequenceDto>.fromJson(responseBody, (json) => NumberSequenceDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto<NumberSequenceDto>> deleteNumberSequence(int numberSequenceId) async {
    final dio = await loadDio();
    const path = ApiPath.deleteNumberSequence;
    final response = await dio.delete("$path/$numberSequenceId");
    return ApiResponseDto<NumberSequenceDto>.fromJson(response.data as Map<String, dynamic>, (json) => NumberSequenceDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto<List<NumberSequenceDto>>> fetchNumberSequence() async {
    final dio = await loadDio();
    final response = await dio.get(ApiPath.fetchNumberSequence);

    return ApiResponseDto<List<NumberSequenceDto>>.fromJson(response.data as Map<String, dynamic>,
        (json) => List<NumberSequenceDto>.from(json.map((e) => NumberSequenceDto.fromJson(e as Map<String, dynamic>)).toList()));
  }

  @override
  Future<ApiResponseDto<NumberSequenceDto>> fetchNumberSequenceById(int numberSequenceId) async {
    final dio = await loadDio();
    var path = ApiPath.fetchNumberSequenceById;
    final response = await dio.get('$path/$numberSequenceId');

    return ApiResponseDto<NumberSequenceDto>.fromJson(response.data as Map<String, dynamic>, (json) => NumberSequenceDto.fromJson(json as Map<String, dynamic>));
  }

  @override
  Future<ApiResponseDto<NumberSequenceDto>> updateNumberSequence(NumberSequenceDto numberSequence) async {
    final dio = await loadDio();
    final response = await dio.put(
      ApiPath.updateNumberSequence,
      data: numberSequence,
    );
    var responseBody = response.data as Map<String, dynamic>;
    return ApiResponseDto<NumberSequenceDto>.fromJson(responseBody, (json) => NumberSequenceDto.fromJson(json as Map<String, dynamic>));
  }
}
