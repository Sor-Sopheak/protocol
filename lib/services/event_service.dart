import 'dart:convert';
import 'package:protocol_app/constants/api_constants.dart';
import 'package:universal_html/html.dart' as html;

import 'package:http/http.dart' as http;
import 'package:protocol_app/models/event_model.dart';
import 'package:protocol_app/models/responses/error_response_model.dart';
import 'package:protocol_app/models/responses/response_model.dart';

class EventService {
  final http.Client client;
  EventService({required this.client});

  Future<dynamic> fetchEvents(
    String? keyword,
    bool? isConfidential,
    String? schedule,
    String? status,
    String? priority,
    int? currentPage,
    int? pageSize,
  ) async {
    try {
      final queryParams = {
        'keyword': keyword ?? '',
        'is_confidential': (isConfidential ?? false).toString(),
        'schedule': schedule ?? 'all',
        'status': status ?? 'all',
        'priority': priority ?? 'all',
        'current_page': currentPage.toString(),
        'page_size': pageSize.toString(),
      };
      final uri =
          ApiConstants.getListEventsUri().replace(queryParameters: queryParams);
      final accessToken = html.window.localStorage['access_token'];
      final response = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        return ResponseModel<EventModel>.fromJson(
          data,
          (itemJson) => EventModel.fromJson(itemJson),
          listKey: 'events',
        );
      } else {
        return ErrorResponseModel.fromJson(data);
      }
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
