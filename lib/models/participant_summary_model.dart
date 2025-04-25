class ParticipantSummaryModel {
  final int confirmed;
  final int error;
  final int inPreparation;
  final int notAttending;
  final int representative;
  final int waiting;

  ParticipantSummaryModel({
    required this.confirmed,
    required this.error,
    required this.inPreparation,
    required this.notAttending,
    required this.representative,
    required this.waiting,
  });

  factory ParticipantSummaryModel.fromJson(Map<String, dynamic> json) {
    return ParticipantSummaryModel(
        confirmed: json['confirmed'] ?? 0,
        error: json['error'] ?? 0,
        inPreparation: json['in_preparation'] ?? 0,
        notAttending: json['not_attending'] ?? 0,
        representative: json['representative'] ?? 0,
        waiting: json['waiting'] ?? 0);
  }

  Map<String, Object> toJson() {
    return {
      'confirmed': confirmed,
      'error': error,
      'in_preparation': inPreparation,
      'not_attending': notAttending,
      'representative': representative,
      'waiting': waiting,
    };
  }

  @override
  String toString() =>
      'ParticipantSummaryModel(confirmed: $confirmed, error: $error, in_preparation: $inPreparation, not_attending: $notAttending, representative: $representative, waiting: $waiting)';
}