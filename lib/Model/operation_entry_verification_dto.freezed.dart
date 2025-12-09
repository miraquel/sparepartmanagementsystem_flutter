// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operation_entry_verification_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OperationEntryVerificationDto {

 int get operationEntryVerificationId; int get operationEntryHeaderId; int get operationTemplateVerificatorId; String? get createdBy; DateTime? get createdDateTime; String? get modifiedBy; DateTime? get modifiedDateTime;
/// Create a copy of OperationEntryVerificationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OperationEntryVerificationDtoCopyWith<OperationEntryVerificationDto> get copyWith => _$OperationEntryVerificationDtoCopyWithImpl<OperationEntryVerificationDto>(this as OperationEntryVerificationDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OperationEntryVerificationDto&&(identical(other.operationEntryVerificationId, operationEntryVerificationId) || other.operationEntryVerificationId == operationEntryVerificationId)&&(identical(other.operationEntryHeaderId, operationEntryHeaderId) || other.operationEntryHeaderId == operationEntryHeaderId)&&(identical(other.operationTemplateVerificatorId, operationTemplateVerificatorId) || other.operationTemplateVerificatorId == operationTemplateVerificatorId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdDateTime, createdDateTime) || other.createdDateTime == createdDateTime)&&(identical(other.modifiedBy, modifiedBy) || other.modifiedBy == modifiedBy)&&(identical(other.modifiedDateTime, modifiedDateTime) || other.modifiedDateTime == modifiedDateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,operationEntryVerificationId,operationEntryHeaderId,operationTemplateVerificatorId,createdBy,createdDateTime,modifiedBy,modifiedDateTime);

@override
String toString() {
  return 'OperationEntryVerificationDto(operationEntryVerificationId: $operationEntryVerificationId, operationEntryHeaderId: $operationEntryHeaderId, operationTemplateVerificatorId: $operationTemplateVerificatorId, createdBy: $createdBy, createdDateTime: $createdDateTime, modifiedBy: $modifiedBy, modifiedDateTime: $modifiedDateTime)';
}


}

/// @nodoc
abstract mixin class $OperationEntryVerificationDtoCopyWith<$Res>  {
  factory $OperationEntryVerificationDtoCopyWith(OperationEntryVerificationDto value, $Res Function(OperationEntryVerificationDto) _then) = _$OperationEntryVerificationDtoCopyWithImpl;
@useResult
$Res call({
 int operationEntryVerificationId, int operationEntryHeaderId, int operationTemplateVerificatorId, String? createdBy, DateTime? createdDateTime, String? modifiedBy, DateTime? modifiedDateTime
});




}
/// @nodoc
class _$OperationEntryVerificationDtoCopyWithImpl<$Res>
    implements $OperationEntryVerificationDtoCopyWith<$Res> {
  _$OperationEntryVerificationDtoCopyWithImpl(this._self, this._then);

  final OperationEntryVerificationDto _self;
  final $Res Function(OperationEntryVerificationDto) _then;

/// Create a copy of OperationEntryVerificationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? operationEntryVerificationId = null,Object? operationEntryHeaderId = null,Object? operationTemplateVerificatorId = null,Object? createdBy = freezed,Object? createdDateTime = freezed,Object? modifiedBy = freezed,Object? modifiedDateTime = freezed,}) {
  return _then(OperationEntryVerificationDto(
operationEntryVerificationId: null == operationEntryVerificationId ? _self.operationEntryVerificationId : operationEntryVerificationId // ignore: cast_nullable_to_non_nullable
as int,operationEntryHeaderId: null == operationEntryHeaderId ? _self.operationEntryHeaderId : operationEntryHeaderId // ignore: cast_nullable_to_non_nullable
as int,operationTemplateVerificatorId: null == operationTemplateVerificatorId ? _self.operationTemplateVerificatorId : operationTemplateVerificatorId // ignore: cast_nullable_to_non_nullable
as int,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdDateTime: freezed == createdDateTime ? _self.createdDateTime : createdDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,modifiedBy: freezed == modifiedBy ? _self.modifiedBy : modifiedBy // ignore: cast_nullable_to_non_nullable
as String?,modifiedDateTime: freezed == modifiedDateTime ? _self.modifiedDateTime : modifiedDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [OperationEntryVerificationDto].
extension OperationEntryVerificationDtoPatterns on OperationEntryVerificationDto {
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
