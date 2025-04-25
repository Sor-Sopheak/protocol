class RoleModel {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  RoleModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['role_id'],
      name: json['role_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role_id': id,
      'role_name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'RoleModel(role_id: $id, role_name: $name, created_at: $createdAt, updated_at: $updatedAt)';
  }
}

// {
//     "current_page": 1,
//     "page_size": 10,
//     "roles": [
//         {
//             "created_at": "2025-04-23T15:44:54",
//             "created_by": "se.kimsour@gmail.com",
//             "role_id": 1,
//             "role_name": "Super Admin",
//             "updated_at": "2025-04-23T15:44:54"
//         }
//     ],
//     "total": 1,
//     "total_pages": 1
// }