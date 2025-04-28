import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:protocol_app/constants/api_constants.dart';
import 'package:protocol_app/models/responses/auth_response_model.dart';
import 'package:protocol_app/models/responses/error_response_model.dart';

class AuthService {
  final http.Client client;
  AuthService({required this.client});

  Future<dynamic> login(String email, String password) async {
    try {
      final response = await client.post(
        ApiConstants.loginUri(),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(responseData);
      } else {
        return ErrorResponseModel.fromJson(responseData);
      }
    } catch (e) {
      // Handle potential network or parsing errors
      return ErrorResponseModel(
        status: false,
        errors: {
          'error': [e.toString()]
        },
      );
    }
  }

  // Example method for user logout
  Future<void> logout() async {
    // Implement your logout logic here
  }
}

//error
// {
//     "errors": {
//         "email": [
//             "email is required."
//         ]
//     },
//     "status": false
// }


//sucess
// {
//     "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0NTgwNzM1MSwianRpIjoiZTJiZTE0M2ItNjMxZS00NmQ3LTk3NWQtZjMxYjVlYjNiZTU4IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6InNlLmtpbXNvdXJAZ21haWwuY29tIiwibmJmIjoxNzQ1ODA3MzUxLCJjc3JmIjoiNTZkMDkzOGEtNzM5MS00ZDY5LWE5ZGItNDBmMDRmNDUyNjgwIiwiZXhwIjoxNzQ1ODkzNzUxLCJ1c2VyX2lkIjoxLCJmaXJzdF9uYW1lIjoic2UiLCJsYXN0X25hbWUiOiJraW1zb3VyIiwiZW1haWwiOiJzZS5raW1zb3VyQGdtYWlsLmNvbSJ9.pQj9QQKrmlzyr9zBSsC07t97NEsoJijJnk_oE4q0Df8",
//     "message": "Login successfully",
//     "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0NTgwNzM1MSwianRpIjoiYmNiMjdjYmQtZGFlNy00MjczLTg4YzMtNmNkYzRkOTMyMmNiIiwidHlwZSI6InJlZnJlc2giLCJzdWIiOiJzZS5raW1zb3VyQGdtYWlsLmNvbSIsIm5iZiI6MTc0NTgwNzM1MSwiY3NyZiI6ImZmNDE3OTZhLThmYmMtNDQwZi1iNTUxLWE1NzY2ODMxZTg1MiIsImV4cCI6MTc0ODM5OTM1MSwidXNlcl9pZCI6MSwiZmlyc3RfbmFtZSI6InNlIiwibGFzdF9uYW1lIjoia2ltc291ciIsImVtYWlsIjoic2Uua2ltc291ckBnbWFpbC5jb20ifQ.DaDFhfPNC9MfBpf5pYIZoskasjlOBCElFHpDrmjbcGQ",
//     "status": true
// }