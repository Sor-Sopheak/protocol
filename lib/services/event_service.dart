import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:protocol_app/constants/api_constants.dart';
import 'package:protocol_app/models/event_model.dart';
import 'package:protocol_app/models/responses/error_response_model.dart';
import 'package:protocol_app/models/responses/response_model.dart';

class EventService {
  final http.Client apiClient;

  EventService({required this.apiClient});

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
      final queryParams = {
        'keyword': keyword,
        'is_confidential': isConfidential,
        'schedule': schedule,
        'status': status,
        'priority': priority,
        'current_page': currentPage.toString(),
        'page_size': pageSize.toString(),
      };

      final uri =
          ApiConstants.getListEventsUri().replace(queryParameters: queryParams);

      final response = await apiClient.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final responseData = data['data'] ?? {};
        if (responseData != null) {
          return ResponseModel<EventModel>.fromJson(
            responseData,
            (itemJson) => EventModel.fromJson(itemJson),
          );
        } else {
          return ResponseModel(
            currentPage: 0,
            items: [],
            pageSize: 0,
            total: 0,
          ); 
        }

      } else {
        return ResponseModel(
          currentPage: 0,
          items: [],
          pageSize: 0,
          total: 0,
        ); 
      }
    } catch (e) {
      // Handle error
      return ErrorResponseModel(
        errors: {'error': e.toString()},
        status: false,
      );
    }
  }
}
