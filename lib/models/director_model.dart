class DirectorModel {
  final String directorType;
  final String email;
  final String enName;
  final int id;
  final String khName;
  final String title;

  DirectorModel({
    required this.directorType,
    required this.email,
    required this.enName,
    required this.id,
    required this.khName,
    required this.title,
  });

  factory DirectorModel.fromJson(Map<String, dynamic> json) {
    return DirectorModel(
      directorType: json['director_type'],
      email: json['email'],
      enName: json['en_name'],
      id: json['id'],
      khName: json['kh_name'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'director_type': directorType,
      'email': email,
      'en_name': enName,
      'id': id,
      'kh_name': khName,
      'title': title,
    };
  }

  @override
  String toString() =>
      'DirectorModel(director_type: $directorType, email: $email, en_name: $enName, id: $id, kh_name: $khName, title: $title)';
}