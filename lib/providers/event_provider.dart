import 'package:flutter/material.dart';
import 'package:protocol_app/models/event_model.dart';
import 'package:protocol_app/models/priority_level_enum.dart';
import 'package:protocol_app/models/responses/error_response_model.dart';
import 'package:protocol_app/models/responses/response_model.dart';
import 'package:protocol_app/models/status_enum.dart';
import 'package:protocol_app/services/event_service.dart';

class EventProvider with ChangeNotifier {
  final EventService eventService;
  EventProvider({required this.eventService});

  bool _isLoading = true;
  List<EventModel> _events = [];
  int _total = 0;
  Set<String> _selectedEventIds = {};
  String _keyword = '';
  String _schedule = 'all';
  bool _isConfidential = false;
  PriorityLevelEnum _priority = PriorityLevelEnum.all;
  StatusEnum _status = StatusEnum.all;

  bool get isLoading => _isLoading;
  List<EventModel> get events => _events;
  int get total => _total;
  Set<String> get selectedEventIds => _selectedEventIds;
  String get keyword => _keyword;
  String get schedule => _schedule;
  bool get isConfidential => _isConfidential;
  PriorityLevelEnum get priority => _priority;
  StatusEnum get status => _status;

  set isConfidential(bool value) {
    if (_isConfidential != value) {
      _isConfidential = value;
      notifyListeners();
    }
  }

  set priority(PriorityLevelEnum value) {
    if (_priority != value) {
      _priority = value;
      notifyListeners();
    }
  }

  void toggleSelection(String eventId, bool isSelected) {
    if (isSelected) {
      _selectedEventIds.add(eventId);
    } else {
      _selectedEventIds.remove(eventId);
    }
    notifyListeners();
  }

  // Method to toggle the selection of all events
  void toggleSelectAll(bool? isSelected) {
    if (isSelected == true) {
      _selectedEventIds = _events.map((e) => e.id.toString()).toSet();
    } else {
      _selectedEventIds.clear();
    }
    notifyListeners();
  }

  // Method to check if an event is currently selected
  bool isItemSelected(EventModel event) {
    return _selectedEventIds.contains(event.id.toString());
  }

  Future<void> fetchEvents(
      String? keyword,
      bool? isConfidential,
      String? schedule,
      String? status,
      String? priority,
      int? currentPage,
      int? pageSize) async {

    _isLoading = true;

    try {
      final result = await eventService.fetchEvents(keyword, isConfidential,
          schedule, status, priority, currentPage, pageSize);

      if (result is ResponseModel<EventModel>) {
        _events = result.items;
        _total = result.total;
        print('Total events: $_total');
        _selectedEventIds.clear(); // clear selections on successful data fetch
      } else if (result is ErrorResponseModel) {
        _events = [];
        _total = 0;
        throw Exception(
            'Failed to fetch events: ${result.errors['error'] ?? 'Unknown error'}');
      } else {
        _events = [];
        _total = 0;
        throw Exception('Failed to fetch events: Unexpected response type');
      }
    } catch (e) {
      _events = [];
      _total = 0;
      debugPrint('Failed to fetch events: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
