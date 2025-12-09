// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operation_template_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OperationTemplateDto {

 int? get operationTemplateId; int? get operationTypeId; String? get name; String? get documentNo; String? get revision; DateTime? get effectiveDate; String? get description; String? get documentRetentionPeriod; String? get createdBy; DateTime? get createdDateTime; String? get modifiedBy; DateTime? get modifiedDateTime;
/// Create a copy of OperationTemplateDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OperationTemplateDtoCopyWith<OperationTemplateDto> get copyWith => _$OperationTemplateDtoCopyWithImpl<OperationTemplateDto>(this as OperationTemplateDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OperationTemplateDto&&(identical(other.operationTemplateId, operationTemplateId) || other.operationTemplateId == operationTemplateId)&&(identical(other.operationTypeId, operationTypeId) || other.operationTypeId == operationTypeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.documentNo, documentNo) || other.documentNo == documentNo)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.effectiveDate, effectiveDate) || other.effectiveDate == effectiveDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.documentRetentionPeriod, documentRetentionPeriod) || other.documentRetentionPeriod == documentRetentionPeriod)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdDateTime, createdDateTime) || other.createdDateTime == createdDateTime)&&(identical(other.modifiedBy, modifiedBy) || other.modifiedBy == modifiedBy)&&(identical(other.modifiedDateTime, modifiedDateTime) || other.modifiedDateTime == modifiedDateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,operationTemplateId,operationTypeId,name,documentNo,revision,effectiveDate,description,documentRetentionPeriod,createdBy,createdDateTime,modifiedBy,modifiedDateTime);

@override
String toString() {
  return 'OperationTemplateDto(operationTemplateId: $operationTemplateId, operationTypeId: $operationTypeId, name: $name, documentNo: $documentNo, revision: $revision, effectiveDate: $effectiveDate, description: $description, documentRetentionPeriod: $documentRetentionPeriod, createdBy: $createdBy, createdDateTime: $createdDateTime, modifiedBy: $modifiedBy, modifiedDateTime: $modifiedDateTime)';
}


}

/// @nodoc
abstract mixin class $OperationTemplateDtoCopyWith<$Res>  {
  factory $OperationTemplateDtoCopyWith(OperationTemplateDto value, $Res Function(OperationTemplateDto) _then) = _$OperationTemplateDtoCopyWithImpl;
@useResult
$Res call({
 int? operationTemplateId, int? operationTypeId, String? name, String? documentNo, String? revision, DateTime? effectiveDate, String? description, String? documentRetentionPeriod, String? createdBy, DateTime? createdDateTime, String? modifiedBy, DateTime? modifiedDateTime
});




}
/// @nodoc
class _$OperationTemplateDtoCopyWithImpl<$Res>
    implements $OperationTemplateDtoCopyWith<$Res> {
  _$OperationTemplateDtoCopyWithImpl(this._self, this._then);

  final OperationTemplateDto _self;
  final $Res Function(OperationTemplateDto) _then;

/// Create a copy of OperationTemplateDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? operationTemplateId = freezed,Object? operationTypeId = freezed,Object? name = freezed,Object? documentNo = freezed,Object? revision = freezed,Object? effectiveDate = freezed,Object? description = freezed,Object? documentRetentionPeriod = freezed,Object? createdBy = freezed,Object? createdDateTime = freezed,Object? modifiedBy = freezed,Object? modifiedDateTime = freezed,}) {
  return _then(OperationTemplateDto(
operationTemplateId: freezed == operationTemplateId ? _self.operationTemplateId : operationTemplateId // ignore: cast_nullable_to_non_nullable
as int?,operationTypeId: freezed == operationTypeId ? _self.operationTypeId : operationTypeId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,documentNo: freezed == documentNo ? _self.documentNo : documentNo // ignore: cast_nullable_to_non_nullable
as String?,revision: freezed == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as String?,effectiveDate: freezed == effectiveDate ? _self.effectiveDate : effectiveDate // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,documentRetentionPeriod: freezed == documentRetentionPeriod ? _self.documentRetentionPeriod : documentRetentionPeriod // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdDateTime: freezed == createdDateTime ? _self.createdDateTime : createdDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,modifiedBy: freezed == modifiedBy ? _self.modifiedBy : modifiedBy // ignore: cast_nullable_to_non_nullable
as String?,modifiedDateTime: freezed == modifiedDateTime ? _self.modifiedDateTime : modifiedDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [OperationTemplateDto].
extension OperationTemplateDtoPatterns on OperationTemplateDto {
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
