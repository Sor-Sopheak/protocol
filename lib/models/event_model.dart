import 'package:protocol_app/models/director_model.dart';
import 'package:protocol_app/models/file_model.dart';
import 'package:protocol_app/models/participant_summary_model.dart';
import 'package:protocol_app/models/priority_level_enum.dart';
import 'package:protocol_app/models/status_enum.dart';

class EventModel {
  int? id;
  StatusEnum? status;
  PriorityLevelEnum priority;
  bool isConfidential;
  String? announcementTitle;
  String title;
  String date;
  String time;
  String location;
  String room;
  String? noted;
  String? gratitude;
  List<DirectorModel>? directors;
  List<FileModel>? files;
  ParticipantSummaryModel participantSummary;
  String? updatedAt;

  EventModel({
    this.id,
    this.status,
    required this.priority,
    required this.isConfidential,
    this.announcementTitle,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.room,
    this.noted,
    this.gratitude,
    this.directors,
    this.files,
    required this.participantSummary,
    this.updatedAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['event_id'] as int? ?? 0,
      status: json['status'] != null
          ? StatusEnumExtension.fromString(json['status'] ?? 'all')
          : null,
      priority:
          PriorityLevelEnumExtension.fromString(json['priority'] ?? 'all'),
      isConfidential: json['is_confidential'] ?? false,
      announcementTitle: json['announcement_title'] ?? '',
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      location: json['location'] ?? '',
      room: json['room'] ?? '',
      noted: json['noted'] ?? '',
      gratitude: json['gratitude'] ?? '',
      directors: (json['directors'] is List)
          ? (json['directors'] as List)
              .map((item) => DirectorModel.fromJson(item))
              .toList()
          : [],
      files: (json['files'] is List)
          ? (json['files'] as List)
              .map((item) => FileModel.fromJson(item))
              .toList()
          : [],
      participantSummary:
          ParticipantSummaryModel.fromJson(json['participant_summary'] ?? {}),
      updatedAt: json['updated_at']?.toString(),
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
