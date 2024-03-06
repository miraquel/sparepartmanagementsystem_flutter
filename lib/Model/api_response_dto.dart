class ApiResponseDto<T> {
  final T? data;
  final String error;
  final String errorMessages;
  final String message;
  final bool success;

  ApiResponseDto({
    this.data,
    this.error = '',
    this.errorMessages = '',
    this.message = '',
    required this.success
  });

  factory ApiResponseDto.fromJson(Map<String, dynamic> json, Function(dynamic) create) => ApiResponseDto<T>(
    data: create(json['data']),
    error: json['error'] ?? '',
    errorMessages: json['errorMessages'] ?? '',
    message: json['message'] ?? '',
    success: json['success'] as bool
  );

  Map<String, dynamic> toJson() => {
    if (data != null) 'data': data,
    if (error.isNotEmpty) 'error': error,
    if (errorMessages.isNotEmpty) 'errorMessages': errorMessages,
    if (message.isNotEmpty) 'message': message,
    'success': success
  };
}