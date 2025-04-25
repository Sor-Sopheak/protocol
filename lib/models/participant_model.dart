class ParticipantModel {
  final int? id;
  final String khName;
  final String enName;
  final String gender;
  final String email;
  final String phoneNumber;
  final String department;
  final String position;
  final String idNumber;
  final String title;
  final int level;
  final String createdBy;
  final String? createdAt;
  final String? updatedAt;

  ParticipantModel({
    required this.id,
    required this.khName,
    required this.enName,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.department,
    required this.position,
    required this.idNumber,
    required this.title,
    required this.level,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
      id: json['participant_id'],
      khName: json['kh_name'],
      enName: json['en_name'],
      gender: json['gender'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      department: json['department'],
      position: json['position'],
      idNumber: json['id_number'],
      title: json['title'],
      level: json['level'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'participant_id': id,
      'kh_name': khName,
      'en_name': enName,
      'gender': gender,
      'email': email,
      'phone_number': phoneNumber,
      'department': department,
      'position': position,
      'id_number': idNumber,
      'title': title,
      'level': level,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'ParticipantModel(participant_id: $id, khName: $khName, enName: $enName, gender: $gender, email: $email, phoneNumber: $phoneNumber, department: $department, position: $position, idNumber: $idNumber, title: $title, level: $level, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
