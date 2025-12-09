import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/Model/Enums/eam_preventive_type.dart';

part 'eam_task_dto.freezed.dart';
part 'eam_task_dto.g.dart';

@freezed
@JsonSerializable()
class EamTaskDto with _$EamTaskDto {
  @override
  String? taskId;
  @override
  String? taskName;
  @override
  EamPreventiveType? preventiveType;

  EamTaskDto({
    this.taskId,
    this.taskName,
    this.preventiveType,
  });

  factory EamTaskDto.fromJson(Map<String, dynamic> json) => _$EamTaskDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EamTaskDtoToJson(this);
}