class ApiResponse<T> {
  final T? data;
  final String error;
  final List<String> errorMessages;
  final String message;
  final bool success;

  ApiResponse({
    this.data,
    this.error = '',
    this.errorMessages = const [],
    this.message = '',
    required this.success
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, [Function(dynamic)? create]) => ApiResponse<T>(
      data: create != null && json['data'] != null ? create(json['data']) : null,
      error: json['error'] ?? '',
      errorMessages: json['errorMessages'] != null ? json['errorMessages'].map<String>((e) => e as String).toList() : [],
      message: json['message'] ?? '',
      success: json['success'] as bool? ?? false
  );

  Map<String, dynamic> toJson() => {
    if (data != null) 'data': data,
    if (error.isNotEmpty) 'error': error,
    if (errorMessages.isNotEmpty) 'errorMessages': errorMessages,
    if (message.isNotEmpty) 'message': message,
    'success': success
  };
}