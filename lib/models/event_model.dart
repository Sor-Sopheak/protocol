import 'package:protocol_app/models/director_model.dart';
import 'package:protocol_app/models/file_model.dart';
import 'package:protocol_app/models/participant_summary_model.dart';

class EventModel {
  String? id;
  String status;
  String priority;
  bool isConfidential;
  String announcementTitle;
  String title;
  String date;
  String time;
  String location;
  String room;
  String noted;
  String gratitude;
  List<DirectorModel>? directors; //directedBy
  List<FileModel> files;
  ParticipantSummaryModel participantSummary;
  String? updatedAt;

  EventModel({
    this.id,
    required this.status,
    required this.priority,
    required this.isConfidential,
    required this.announcementTitle,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.room,
    required this.noted,
    required this.gratitude,
    required this.directors,
    required this.files,
    required this.participantSummary,
    this.updatedAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['event_id'] as String?,
      status: json['status'], //status
      priority: json['priority'],
      isConfidential: json['is_confidential'],
      announcementTitle: json['announcement_title'],
      title: json['title'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
      room: json['room'],
      noted: json['noted'],
      gratitude: json['gratitude'],
      directors: List<DirectorModel>.from(json['directors'] ?? []),
      files: List<FileModel>.from(json['files'] ?? []),
      participantSummary:
          ParticipantSummaryModel.fromJson(json['participant_summary']),
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': id,
      'status': status,
      'priority': priority,
      'is_confidential': isConfidential,
      'announcement_title': announcementTitle,
      'title': title,
      'date': date,
      'time': time,
      'location': location,
      'room': room,
      'noted': noted,
      'gratitude': gratitude,
      'directors': directors,
      'files': files,
      'participant_summary': participantSummary,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() =>
      'EventModel(event_id: $id, status: $status, priority: $priority, is_confidential: $isConfidential, announcement_title: $announcementTitle, title: $title, date: $date, time: $time, location: $location, room: $room, noted: $noted, gratitude: $gratitude, directors: $directors, files: $files, participant_summary: $participantSummary, updated_at: $updatedAt)';
}
