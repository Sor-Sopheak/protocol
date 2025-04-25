class AuthResponseModel {
  String accessToken;
  String refreshToken;
  String message;
  bool status;

  AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.message,
    required this.status,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      message: json['message'] as String,
      status: json['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'message': message,
      'status': status,
    };
  }

  @override
  String toString() {
    return 'AuthResponseModel{access_token: $accessToken, refresh_token: $refreshToken, message: $message, status: $status}';
  }
}


// {
//     "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0NTU3NTAzMiwianRpIjoiNjNmNmFmN2UtOTAwYy00YjM0LTgzNjgtNjg4ZDI2OWFhZWQ3IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6InNlLmtpbXNvdXJAZ21haWwuY29tIiwibmJmIjoxNzQ1NTc1MDMyLCJjc3JmIjoiZTIwMjUzNGItMWJiNi00ODM0LWExMmYtNDk2ZDkxZWQxN2U3IiwiZXhwIjoxNzQ1NjYxNDMyLCJ1c2VyX2lkIjoxLCJmaXJzdF9uYW1lIjoic2UiLCJsYXN0X25hbWUiOiJraW1zb3VyIiwiZW1haWwiOiJzZS5raW1zb3VyQGdtYWlsLmNvbSJ9.Bdpnd_8UmUxPpHxCoKkg_xGHtKFCJiTy3BIwwy0EnwE",
//     "message": "Login successfully",
//     "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0NTU3NTAzMiwianRpIjoiMThiMDc1MjYtY2FhOS00NDQzLTk1YjUtNTAwYzQxOWQ1MmQzIiwidHlwZSI6InJlZnJlc2giLCJzdWIiOiJzZS5raW1zb3VyQGdtYWlsLmNvbSIsIm5iZiI6MTc0NTU3NTAzMiwiY3NyZiI6ImViZTExMGVlLTA3MTEtNGEyNC05YTQ4LTJjMGNjNTBkOTMwZiIsImV4cCI6MTc0ODE2NzAzMiwidXNlcl9pZCI6MSwiZmlyc3RfbmFtZSI6InNlIiwibGFzdF9uYW1lIjoia2ltc291ciIsImVtYWlsIjoic2Uua2ltc291ckBnbWFpbC5jb20ifQ.vnFfzrPpJV7KtOGvP7suHdVqeT_9_5Vq46rPeeZPFRk",
//     "status": true
// }
