enum StatusEnum {
  all,
  draft,
  published,
  completed,
}

extension StatusEnumExtension on StatusEnum {
  String get statusText {
    switch (this) {
      case StatusEnum.all:
        return 'All';
      case StatusEnum.draft:
        return 'Draft';
      case StatusEnum.published:
        return 'Published';
      case StatusEnum.completed:
        return 'Completed';
    }
  }

  static StatusEnum fromString(String status) {
    switch (status.toLowerCase()) {
      case 'all':
        return StatusEnum.all;
      case 'draft':
        return StatusEnum.draft;
      case 'published':
        return StatusEnum.published;
      case 'completed':
        return StatusEnum.completed;
      default:
        throw ArgumentError('Invalid status value: $status');
    }
  }
}
