import 'package:freezed_annotation/freezed_annotation.dart';

enum OperationTemplateDataType {
  @JsonValue(0) empty, // A null reference.
  // @JsonValue(1) object, // A general type representing any reference or value type not explicitly represented by another TypeCode.
  // @JsonValue(2) dbNull, // A database null (column) value.
  @JsonValue(3) boolean, // A simple type representing Boolean values of true or false.
  @JsonValue(4) char, // An integral type representing unsigned 16-bit integers with values between 0 and 65535. The set of possible values for the Char type corresponds to the Unicode character set.
  // @JsonValue(5) sByte, // An integral type representing signed 8-bit integers with values between -128 and 127.
  // @JsonValue(6) byte, // An integral type representing unsigned 8-bit integers with values between 0 and 255.
  // @JsonValue(7) int16, // An integral type representing signed 16-bit integers with values between -32768 and 32767.
  // @JsonValue(8) uint16, // An integral type representing unsigned 16-bit integers with values between 0 and 65535.
  @JsonValue(9) int32, // An integral type representing signed 32-bit integers with values between -2147483648 and 2147483647.
  @JsonValue(10) uint32, // An integral type representing unsigned 32-bit integers with values between 0 and 4294967295.
  @JsonValue(11) int64, // An integral type representing signed 64-bit integers with values between -9223372036854775808 and 9223372036854775807.
  @JsonValue(12) uint64, // An integral type representing unsigned 64-bit integers with values between 0 and 18446744073709551615.
  // @JsonValue(13) single, // A floating point type representing values ranging from approximately 1.5 x 10 -45 to 3.4 x 10 38 with a precision of 7 digits.
  @JsonValue(14) double, // A floating point type representing values ranging from approximately 5.0 x 10 -324 to 1.7 x 10 308 with a precision of 15-16 digits.
  @JsonValue(15) decimal, // A simple type representing values ranging from 1.0 x 10 -28 to approximately 7.9 x 10 28 with 28-29 significant digits.
  @JsonValue(16) dateTime, // A type representing a date and time value.
  @JsonValue(18) string; // A sealed class type representing Unicode character strings.

  @override
  String toString() {
    switch (this) {
      case OperationTemplateDataType.empty:
        return 'Empty';
      // case OperationTemplateDataType.object:
      //   return 'Object';
      // case OperationTemplateDataType.dbNull:
      //   return 'DB Null';
      case OperationTemplateDataType.boolean:
        return 'Boolean';
      case OperationTemplateDataType.char:
        return 'Char';
      // case OperationTemplateDataType.sByte:
      //   return 'SByte';
      // case OperationTemplateDataType.byte:
      //   return 'Byte';
      // case OperationTemplateDataType.int16:
      //   return 'Int16';
      // case OperationTemplateDataType.uint16:
      //   return 'UInt16';
      case OperationTemplateDataType.int32:
        return 'Int32';
      case OperationTemplateDataType.uint32:
        return 'UInt32';
      case OperationTemplateDataType.int64:
        return 'Int64';
      case OperationTemplateDataType.uint64:
        return 'UInt64';
      // case OperationTemplateDataType.single:
      //   return 'Single';
      case OperationTemplateDataType.double:
        return 'Double';
      case OperationTemplateDataType.decimal:
        return 'Decimal';
      case OperationTemplateDataType.dateTime:
        return 'DateTime';
      case OperationTemplateDataType.string:
        return 'String';
    }
  }
}