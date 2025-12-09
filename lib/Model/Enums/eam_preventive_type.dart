import 'package:freezed_annotation/freezed_annotation.dart';

enum EamPreventiveType {
  @JsonValue(0) blank,
  @JsonValue(1) elapsedTime,
  @JsonValue(2) statistic,
}