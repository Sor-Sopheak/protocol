class ErrorResponseModel {
  final Map<String, dynamic> errors;
  final bool status;

  ErrorResponseModel({required this.errors, required this.status});

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      errors: json['errors'] as Map<String, dynamic>,
      status: json['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errors': errors,
      'status': status,
    };
  }
}