class FileModel {
  final String? id;
  final String filePath;
  final String fileType;

  FileModel({
    this.id,
    required this.filePath,
    required this.fileType,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'] as String?,
      filePath: json['filePath'],
      fileType: json['fileType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'filePath': filePath,
      'fileType': fileType,
    };
  }

  @override
  String toString() => 'FileModel(id: $id, filePath: $filePath, fileType: $fileType)';
}