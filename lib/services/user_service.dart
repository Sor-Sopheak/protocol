import 'package:http/http.dart' as http;
import 'package:protocol_app/models/responses/error_response_model.dart';
import 'package:protocol_app/models/responses/response_model.dart';
import 'package:protocol_app/models/user_model.dart';

class UserService {
  final http.Client client;
  UserService({required this.client});

  static final _mockUserData = {
    'current_page': 1,
    'page_size': 10,
    'total': 3,
    'users': [
      {
        "user_id": 1,
        "first_name": "First1",
        "last_name": "Lasatname1",
        "email": "name1@gov.kh",
        "profile_image": null,
        "is_lock": false,
        "role_id": "Super Admin",
        "created_by": "admin1@gmail.com",
        "created_at": "2025-04-23T15:44:55",
        "updated_at": "2025-04-23T15:44:55"
      },
      {
        "user_id": 2,
        "first_name": "First2",
        "last_name": "Lasatname2",
        "email": "name2@gov.kh",
        "profile_image": null,
        "is_lock": false,
        "role_id": "Admin",
        "created_by": "admin2@gmail.com",
        "created_at": "2025-04-23T15:44:55",
        "updated_at": "2025-04-23T15:44:55"
      },
      {
        "user_id": 3,
        "first_name": "First3",
        "last_name": "Lasatname3",
        "email": "name3@gov.kh",
        "profile_image": null,
        "is_lock": false,
        "role_id": "Admin",
        "created_by": "admin3@gmail.com",
        "created_at": "2025-04-23T15:44:55",
        "updated_at": "2025-04-23T15:44:55"
      }
    ],
  };

  Future<dynamic> fetchUsers(
    String? keyword,
    int currentPage,
    int pageSize,
  ) async {
    try {
      List<dynamic> filteredUsers =
          (_mockUserData['users'] as List<dynamic>?)?.where((user) {
                final keywordMatch = keyword == null ||
                    (user['first_name'] as String)
                        .toLowerCase()
                        .contains(keyword.toLowerCase()) ||
                    (user['last_name'] as String)
                        .toLowerCase()
                        .contains(keyword.toLowerCase()) ||
                    (user['email'] as String)
                        .toLowerCase()
                        .contains(keyword.toLowerCase());

                return keywordMatch;
              }).toList() ??
              [];

      final startIndex = (currentPage - 1) * pageSize;
      final endIndex = startIndex + pageSize;
      final paginatedUsers = filteredUsers.sublist(
        startIndex < filteredUsers.length ? startIndex : 0,
        endIndex < filteredUsers.length ? endIndex : filteredUsers.length,
      );

      final total = _mockUserData['total'] as int? ?? 0;
      final totalPage = (total / pageSize).ceil();

      final responseData = {
        'current_page': currentPage,
        'page_size': pageSize,
        'total': filteredUsers.length,
        'total_page': totalPage,
        'users': paginatedUsers,
      };

      return ResponseModel<UserModel>.fromJson(
        responseData,
        (itemJson) => UserModel.fromJson(itemJson),
      );
    } catch (e) {
      return ErrorResponseModel(
        errors: {'error': e.toString()},
        status: false,
      );
    }
  }
}
