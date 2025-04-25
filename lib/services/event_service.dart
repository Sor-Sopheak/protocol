import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:protocol_app/models/event_model.dart';
import 'package:protocol_app/models/responses/error_response_model.dart';
import 'package:protocol_app/models/responses/response_model.dart';

class EventService {
  final http.Client client;
  static final _mockEventsData = {
    'current_page': 1,
    'page_size': 10,
    'total': 3,
    'events': [
      {
        "event_id": "1",
        "status": "draft",
        "priority": "normal",
        "is_confidential": false,
        "announcement_title": "Press Release",
        "title": "Information Announcement",
        "date": "April 26, 2025",
        "time": "12:00 PM",
        "location": "Ministry of...",
        "room": "A2",
        "noted": "...",
        "gratitude": "...",
        "directors": [
          {
            "director_type": "Host",
            "email": "host@example.com",
            "en_name": "Host One",
            "id": 101,
            "kh_name": "អ្នករៀបចំ មួយ",
            "title": "Mr."
          },
        ],
        "files": [
          {"id": "f1", "filePath": "/path/to/file1.pdf", "fileType": "pdf"},
        ],
        "participant_summary": {
          "confirmed": 5,
          "error": 0,
          "in_preparation": 2,
          "not_attending": 1,
          "representative": 0,
          "waiting": 0
        },
        "updated_at": "2025-04-25T10:00:00Z",
      },
      {
        "event_id": "2",
        "status": "scheduled",
        "priority": "high",
        "is_confidential": true,
        "announcement_title": "Internal Memo",
        "title": "Project X Meeting",
        "date": "April 27, 2025",
        "time": "02:30 PM",
        "location": "Office Building",
        "room": "Conference Room 1",
        "noted": "...",
        "gratitude": "...",
        "directors": [
          {
            "director_type": "Lead",
            "email": "lead@example.com",
            "en_name": "Lead Two",
            "id": 102,
            "kh_name": "អ្នកដឹកនាំ ពីរ",
            "title": "Ms."
          },
        ],
        "files": [],
        "participant_summary": {
          "confirmed": 10,
          "error": 1,
          "in_preparation": 0,
          "not_attending": 2,
          "representative": 3,
          "waiting": 1
        },
        "updated_at": "2025-04-25T11:30:00Z",
      },
      {
        "event_id": "3",
        "status": "completed",
        "priority": "normal",
        "is_confidential": false,
        "announcement_title": "Follow-up Notes",
        "title": "Workshop Review",
        "date": "April 28, 2025",
        "time": "09:00 AM",
        "location": "Training Center",
        "room": "Hall B",
        "noted": "...",
        "gratitude": "...",
        "directors": [],
        "files": [
          {"id": "f2", "filePath": "/path/to/file2.docx", "fileType": "docx"},
          {"id": "f3", "filePath": "/path/to/file3.xlsx", "fileType": "xlsx"},
        ],
        "participant_summary": {
          "confirmed": 25,
          "error": 0,
          "in_preparation": 0,
          "not_attending": 0,
          "representative": 0,
          "waiting": 0
        },
        "updated_at": "2025-04-25T12:45:00Z",
      },
    ],
  };

  EventService({required this.client});

  Future<dynamic> fetchEvents(
    String? keyword,
    bool isConfidential,
    String schedule,
    String status,
    String priority,
    int currentPage,
    int pageSize,
  ) async {
    try {
      List<dynamic> filteredEvents =
          (_mockEventsData['events'] as List<dynamic>?)?.where((event) {
                final keywordMatch = keyword == null ||
                    (event['title'] as String)
                        .toLowerCase()
                        .contains(keyword.toLowerCase()) ||
                    (event['announcement_title'] as String)
                        .toLowerCase()
                        .contains(keyword.toLowerCase()) ||
                    (event['location'] as String)
                        .toLowerCase()
                        .contains(keyword.toLowerCase());
                final confidentialMatch =
                    event['is_confidential'] == isConfidential;
                final statusMatch =
                    status == "all" || event['status'] == status;
                final priorityMatch =
                    priority == "all" || event['priority'] == priority;
                final scheduleMatch = schedule == "all" ||
                    (event['date'] as String)
                        .toLowerCase()
                        .contains(schedule.toLowerCase());

                return keywordMatch &&
                    confidentialMatch &&
                    statusMatch &&
                    priorityMatch &&
                    scheduleMatch;
              }).toList() ??
              [];

      final startIndex = (currentPage - 1) * pageSize;
      final endIndex = startIndex + pageSize;
      final paginatedEvents = filteredEvents.sublist(
        startIndex < filteredEvents.length ? startIndex : 0,
        endIndex < filteredEvents.length ? endIndex : filteredEvents.length,
      );

      final responseData = {
        'current_page': currentPage,
        'page_size': pageSize,
        'total': filteredEvents.length,
        'events': paginatedEvents,
      };

      return ResponseModel<EventModel>.fromJson(
        responseData,
        (itemJson) => EventModel.fromJson(itemJson),
      );
    } catch (e) {
      return ErrorResponseModel(
        errors: {'error': e.toString()},
        status: false,
      );
    }
  }

  Future<dynamic> createEvent(EventModel event) async {
    final param = jsonEncode({
      'status': event.status,
      'priority': event.priority,
      'is_confidential': event.isConfidential,
      'announcement_title': event.announcementTitle,
      'title': event.title,
      'date': event.date,
      'time': event.time,
      'location': event.location,
      'room': event.room,
      'noted': event.noted,
      'gratitude': event.gratitude,
      'directed_by': event.directors,
      'files': event.files,
    });
  }
}
