enum StatusEnum {
  draft,
  inProgress,
  confirmation,
  notAttending,
  // onHold,
  // completed,
  // rejected,
  // confirmed,
  // attended,
}

extension StatusEnumExtension on StatusEnum {
  String get statusText {
    switch (this) {
      case StatusEnum.draft:
        return 'Draft';
      case StatusEnum.inProgress:
        return 'In Progress';
      case StatusEnum.confirmation:
        return 'Confirmation';
      case StatusEnum.notAttending:
        return 'Not Attending';
    }
  }

  static StatusEnum fromString(String status) {
    switch (status.toLowerCase()) {
      case 'draft':
        return StatusEnum.draft;
      case 'in progress':
        return StatusEnum.inProgress;
      case 'confirmation':
        return StatusEnum.confirmation;
      case 'not attending':
        return StatusEnum.notAttending;
      default:
        throw ArgumentError('Invalid status value: $status');
    }
  }
}
