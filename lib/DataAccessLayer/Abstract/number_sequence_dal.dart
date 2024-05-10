import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/number_sequence_dto.dart';

abstract class NumberSequenceDAL {
  Future<ApiResponseDto<List<NumberSequenceDto>>> getAllNumberSequence();
  Future<ApiResponseDto<NumberSequenceDto>> getNumberSequenceById(int numberSequenceId);
  Future<ApiResponseDto> addNumberSequence(NumberSequenceDto numberSequence);
  Future<ApiResponseDto> updateNumberSequence(NumberSequenceDto numberSequence);
  Future<ApiResponseDto> deleteNumberSequence(int numberSequenceId);
}