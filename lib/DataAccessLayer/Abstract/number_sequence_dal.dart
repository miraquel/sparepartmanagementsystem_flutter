import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/number_sequence_dto.dart';

abstract class NumberSequenceDAL {
  Future<ApiResponseDto<List<NumberSequenceDto>>> fetchNumberSequence();
  Future<ApiResponseDto<NumberSequenceDto>> fetchNumberSequenceById(int numberSequenceId);
  Future<ApiResponseDto> addNumberSequence(NumberSequenceDto numberSequence);
  Future<ApiResponseDto> updateNumberSequence(NumberSequenceDto numberSequence);
  Future<ApiResponseDto> deleteNumberSequence(int numberSequenceId);
}