enum PriorityLevelEnum { all, urgent, normal }

extension PriorityLevelEnumExtension on PriorityLevelEnum {
  String get priorityText {
    switch (this) {
      case PriorityLevelEnum.all:
        return 'All';
      case PriorityLevelEnum.urgent:
        return 'Urgent';
      case PriorityLevelEnum.normal:
        return 'Normal';
    }
  }

  static PriorityLevelEnum fromString(String priority) {
    switch (priority.toLowerCase()) {
      case 'all':
        return PriorityLevelEnum.all;
      case 'urgent':
        return PriorityLevelEnum.urgent;
      case 'normal':
        return PriorityLevelEnum.normal;
      default:
        throw ArgumentError('Invalid priority value: $priority');
    }
  }
}
