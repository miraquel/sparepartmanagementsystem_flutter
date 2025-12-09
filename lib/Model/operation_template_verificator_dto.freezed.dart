// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operation_template_verificator_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OperationTemplateVerificatorDto {

 int? get operationTemplateVerificatorId; int? get operationTemplateId; String? get name; String? get jobPosition; String? get label; String? get createdBy; DateTime? get createdDateTime; String? get modifiedBy; DateTime? get modifiedDateTime;
/// Create a copy of OperationTemplateVerificatorDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OperationTemplateVerificatorDtoCopyWith<OperationTemplateVerificatorDto> get copyWith => _$OperationTemplateVerificatorDtoCopyWithImpl<OperationTemplateVerificatorDto>(this as OperationTemplateVerificatorDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OperationTemplateVerificatorDto&&(identical(other.operationTemplateVerificatorId, operationTemplateVerificatorId) || other.operationTemplateVerificatorId == operationTemplateVerificatorId)&&(identical(other.operationTemplateId, operationTemplateId) || other.operationTemplateId == operationTemplateId)&&(identical(other.name, name) || other.name == name)&&(identical(other.jobPosition, jobPosition) || other.jobPosition == jobPosition)&&(identical(other.label, label) || other.label == label)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdDateTime, createdDateTime) || other.createdDateTime == createdDateTime)&&(identical(other.modifiedBy, modifiedBy) || other.modifiedBy == modifiedBy)&&(identical(other.modifiedDateTime, modifiedDateTime) || other.modifiedDateTime == modifiedDateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,operationTemplateVerificatorId,operationTemplateId,name,jobPosition,label,createdBy,createdDateTime,modifiedBy,modifiedDateTime);

@override
String toString() {
  return 'OperationTemplateVerificatorDto(operationTemplateVerificatorId: $operationTemplateVerificatorId, operationTemplateId: $operationTemplateId, name: $name, jobPosition: $jobPosition, label: $label, createdBy: $createdBy, createdDateTime: $createdDateTime, modifiedBy: $modifiedBy, modifiedDateTime: $modifiedDateTime)';
}


}

/// @nodoc
abstract mixin class $OperationTemplateVerificatorDtoCopyWith<$Res>  {
  factory $OperationTemplateVerificatorDtoCopyWith(OperationTemplateVerificatorDto value, $Res Function(OperationTemplateVerificatorDto) _then) = _$OperationTemplateVerificatorDtoCopyWithImpl;
@useResult
$Res call({
 int? operationTemplateVerificatorId, int? operationTemplateId, String? name, String? jobPosition, String? label, String? createdBy, DateTime? createdDateTime, String? modifiedBy, DateTime? modifiedDateTime
});




}
/// @nodoc
class _$OperationTemplateVerificatorDtoCopyWithImpl<$Res>
    implements $OperationTemplateVerificatorDtoCopyWith<$Res> {
  _$OperationTemplateVerificatorDtoCopyWithImpl(this._self, this._then);

  final OperationTemplateVerificatorDto _self;
  final $Res Function(OperationTemplateVerificatorDto) _then;

/// Create a copy of OperationTemplateVerificatorDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? operationTemplateVerificatorId = freezed,Object? operationTemplateId = freezed,Object? name = freezed,Object? jobPosition = freezed,Object? label = freezed,Object? createdBy = freezed,Object? createdDateTime = freezed,Object? modifiedBy = freezed,Object? modifiedDateTime = freezed,}) {
  return _then(OperationTemplateVerificatorDto(
operationTemplateVerificatorId: freezed == operationTemplateVerificatorId ? _self.operationTemplateVerificatorId : operationTemplateVerificatorId // ignore: cast_nullable_to_non_nullable
as int?,operationTemplateId: freezed == operationTemplateId ? _self.operationTemplateId : operationTemplateId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,jobPosition: freezed == jobPosition ? _self.jobPosition : jobPosition // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdDateTime: freezed == createdDateTime ? _self.createdDateTime : createdDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,modifiedBy: freezed == modifiedBy ? _self.modifiedBy : modifiedBy // ignore: cast_nullable_to_non_nullable
as String?,modifiedDateTime: freezed == modifiedDateTime ? _self.modifiedDateTime : modifiedDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [OperationTemplateVerificatorDto].
extension OperationTemplateVerificatorDtoPatterns on OperationTemplateVerificatorDto {
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
