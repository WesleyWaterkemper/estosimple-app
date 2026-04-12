class ApiResponse<T> {
  final int status;
  final String message;
  final bool isSuccess;
  final T value;

  ApiResponse({
    required this.status,
    required this.message,
    required this.isSuccess,
    required this.value
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return ApiResponse(
      status: json['status'], 
      message: json['message'], 
      isSuccess: json['isSuccess'], 
      value: fromJsonT(json['value']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'isSuccess': isSuccess,
      'value': value
    };
  }
}