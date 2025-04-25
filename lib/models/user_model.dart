class UserModel {
  String? id;
  String firstName;
  String lastName;
  String email;
  String? profileImage;
  bool islocked;
  String role;
  String createdBy;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profileImage,
    this.islocked = false,
    required this.role,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      profileImage: json['profile_image'],
      islocked: json['is_lock'] ?? false,
      role: json['role_id'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'profile_image': profileImage,
      'is_lock': islocked,
      'role_id': role,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'UserModel{user_id: $id, first_name: $firstName, last_name: $lastName, email: $email, profile_image: $profileImage, is_lock: $islocked, role_id: $role, created_by: $createdBy, created_at: $createdAt, updated_at: $updatedAt}';
  }
}
// {
//   "created_at": "2025-04-23T15:44:55",
//   "created_by": "se.kimsour@gmail.com",
//   "email": "se.kimsour@gmail.com",
//   "first_name": "se",
//   "is_lock": false,
//   "last_name": "kimsour",
//   "profile_image": null,
//   "role_id": "Super Admin",
//   "updated_at": "2025-04-23T15:44:55",
//   "user_id": 1
// },
