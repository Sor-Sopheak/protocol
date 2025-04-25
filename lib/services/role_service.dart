import 'dart:convert';

import 'package:protocol_app/models/role_model.dart';

class RoleService {
  Future<dynamic> getRoles(
    String? keyword,
    int currentPage,
    int pageSize,
  ) async {}

  Future<dynamic> getRoleInfo(String roleId) async {
    final param = jsonEncode({
      'role_id': roleId,
    });
  }

  Future<dynamic> createRole(RoleModel role) async {
    final body = jsonEncode({
      'role_name': role.name,
    });
  }
}

//role response, create response, get info all 
// {
//     "message": "The user was created successfully.",
//     "role_info": {
//         "created_at": "2025-04-25T17:11:05",
//         "created_by": "se.kimsour@gmail.com",
//         "role_id": 2,
//         "role_name": "Member",
//         "updated_at": "2025-04-25T17:11:05"
//     },
//     "status": true
// }