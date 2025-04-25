import 'package:flutter/material.dart';
import 'package:protocol_app/models/event_model.dart';
import 'package:protocol_app/services/event_service.dart';

class EventProvider with ChangeNotifier {
  final EventService eventService;

  EventProvider({required this.eventService});
  bool _isLoading = true;
  List<EventModel> _events = [];
  // ResponseModel<EventModel>? _responseModel;
  // String? _keyword;
  // bool _isConfidential = false;
  // String _schedule = 'all';
  // String _status = 'all'; // all, draft, published, completed.
  // String _priority = 'all'; // all, urgent, normal.
  // int _currentPage = 1;
  // int _pageSize = 10; 
  int _total = 0;

  bool get isLoading => _isLoading;
  List<EventModel> get events => _events;
  // String? get keyword => _keyword;
  // bool? get isConfidential => _isConfidential;
  // String get schedule => _schedule;
  // String get status => _status;
  // String get priority => _priority;
  // int get currentPage => _currentPage;
  // int get pageSize => _pageSize;
  int get total => _total;

  Future<void> allEvents(String? keyword, bool isConfidential, String schedule, String status, String priority, int currentPage, int pageSize) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await eventService.fetchEvents(keyword, isConfidential, schedule, status, priority, currentPage, pageSize);
      
      if (result.success) {
        _events = result.response?.items ?? [];
        _total = result.response?.total ?? 0;
      } else {
        _events = [];
        _total = 0;
      }
    } catch (e) {
      _events = [];
      _total = 0;
      throw Exception('Failed to fetch events: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
