// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operation_template_row_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OperationTemplateRowDto {

 int? get operationTemplateRowId; int? get operationTemplateId; String? get rowLabel; int? get position; String? get createdBy; DateTime? get createdDateTime; String? get modifiedBy; DateTime? get modifiedDateTime;
/// Create a copy of OperationTemplateRowDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OperationTemplateRowDtoCopyWith<OperationTemplateRowDto> get copyWith => _$OperationTemplateRowDtoCopyWithImpl<OperationTemplateRowDto>(this as OperationTemplateRowDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OperationTemplateRowDto&&(identical(other.operationTemplateRowId, operationTemplateRowId) || other.operationTemplateRowId == operationTemplateRowId)&&(identical(other.operationTemplateId, operationTemplateId) || other.operationTemplateId == operationTemplateId)&&(identical(other.rowLabel, rowLabel) || other.rowLabel == rowLabel)&&(identical(other.position, position) || other.position == position)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdDateTime, createdDateTime) || other.createdDateTime == createdDateTime)&&(identical(other.modifiedBy, modifiedBy) || other.modifiedBy == modifiedBy)&&(identical(other.modifiedDateTime, modifiedDateTime) || other.modifiedDateTime == modifiedDateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,operationTemplateRowId,operationTemplateId,rowLabel,position,createdBy,createdDateTime,modifiedBy,modifiedDateTime);

@override
String toString() {
  return 'OperationTemplateRowDto(operationTemplateRowId: $operationTemplateRowId, operationTemplateId: $operationTemplateId, rowLabel: $rowLabel, position: $position, createdBy: $createdBy, createdDateTime: $createdDateTime, modifiedBy: $modifiedBy, modifiedDateTime: $modifiedDateTime)';
}


}

/// @nodoc
abstract mixin class $OperationTemplateRowDtoCopyWith<$Res>  {
  factory $OperationTemplateRowDtoCopyWith(OperationTemplateRowDto value, $Res Function(OperationTemplateRowDto) _then) = _$OperationTemplateRowDtoCopyWithImpl;
@useResult
$Res call({
 int? operationTemplateRowId, int? operationTemplateId, String? rowLabel, int? position, String? createdBy, DateTime? createdDateTime, String? modifiedBy, DateTime? modifiedDateTime
});




}
/// @nodoc
class _$OperationTemplateRowDtoCopyWithImpl<$Res>
    implements $OperationTemplateRowDtoCopyWith<$Res> {
  _$OperationTemplateRowDtoCopyWithImpl(this._self, this._then);

  final OperationTemplateRowDto _self;
  final $Res Function(OperationTemplateRowDto) _then;

/// Create a copy of OperationTemplateRowDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? operationTemplateRowId = freezed,Object? operationTemplateId = freezed,Object? rowLabel = freezed,Object? position = freezed,Object? createdBy = freezed,Object? createdDateTime = freezed,Object? modifiedBy = freezed,Object? modifiedDateTime = freezed,}) {
  return _then(OperationTemplateRowDto(
operationTemplateRowId: freezed == operationTemplateRowId ? _self.operationTemplateRowId : operationTemplateRowId // ignore: cast_nullable_to_non_nullable
as int?,operationTemplateId: freezed == operationTemplateId ? _self.operationTemplateId : operationTemplateId // ignore: cast_nullable_to_non_nullable
as int?,rowLabel: freezed == rowLabel ? _self.rowLabel : rowLabel // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdDateTime: freezed == createdDateTime ? _self.createdDateTime : createdDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,modifiedBy: freezed == modifiedBy ? _self.modifiedBy : modifiedBy // ignore: cast_nullable_to_non_nullable
as String?,modifiedDateTime: freezed == modifiedDateTime ? _self.modifiedDateTime : modifiedDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [OperationTemplateRowDto].
extension OperationTemplateRowDtoPatterns on OperationTemplateRowDto {
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
