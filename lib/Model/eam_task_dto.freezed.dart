// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eam_task_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EamTaskDto {

 String? get taskId; set taskId(String? value); String? get taskName; set taskName(String? value); EamPreventiveType? get preventiveType; set preventiveType(EamPreventiveType? value);
/// Create a copy of EamTaskDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EamTaskDtoCopyWith<EamTaskDto> get copyWith => _$EamTaskDtoCopyWithImpl<EamTaskDto>(this as EamTaskDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EamTaskDto&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.preventiveType, preventiveType) || other.preventiveType == preventiveType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskId,taskName,preventiveType);

@override
String toString() {
  return 'EamTaskDto(taskId: $taskId, taskName: $taskName, preventiveType: $preventiveType)';
}


}

/// @nodoc
abstract mixin class $EamTaskDtoCopyWith<$Res>  {
  factory $EamTaskDtoCopyWith(EamTaskDto value, $Res Function(EamTaskDto) _then) = _$EamTaskDtoCopyWithImpl;
@useResult
$Res call({
 String? taskId, String? taskName, EamPreventiveType? preventiveType
});




}
/// @nodoc
class _$EamTaskDtoCopyWithImpl<$Res>
    implements $EamTaskDtoCopyWith<$Res> {
  _$EamTaskDtoCopyWithImpl(this._self, this._then);

  final EamTaskDto _self;
  final $Res Function(EamTaskDto) _then;

/// Create a copy of EamTaskDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taskId = freezed,Object? taskName = freezed,Object? preventiveType = freezed,}) {
  return _then(EamTaskDto(
taskId: freezed == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String?,taskName: freezed == taskName ? _self.taskName : taskName // ignore: cast_nullable_to_non_nullable
as String?,preventiveType: freezed == preventiveType ? _self.preventiveType : preventiveType // ignore: cast_nullable_to_non_nullable
as EamPreventiveType?,
  ));
}

}


/// Adds pattern-matching-related methods to [EamTaskDto].
extension EamTaskDtoPatterns on EamTaskDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
