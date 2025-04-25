import 'package:flutter/material.dart';
import 'package:protocol_app/models/participant_model.dart';
import 'package:protocol_app/models/responses/error_response_model.dart';
import 'package:protocol_app/models/responses/response_model.dart';
import 'package:protocol_app/services/participant_service.dart';

class ParticipantProvider with ChangeNotifier {
  final ParticipantService participantService;

  ParticipantProvider({required this.participantService});

  bool _isLoading = true;
  List<ParticipantModel> _participants = [];
  Set<String> _selectedItemIds = {};
  String? _selectedDomainId;
  int _total = 0;

  bool get isLoading => _isLoading;
  List<ParticipantModel> get participants => _participants;
  Set<String> get selectedItemIds => _selectedItemIds;
  String? get selectedDomainId => _selectedDomainId;
  int get total => _total;

  void toggleSelection(String itemId, bool isSelected) {
    if (isSelected) {
      _selectedItemIds.add(itemId);
    } else {
      _selectedItemIds.remove(itemId);
    }
    notifyListeners();
  }

  void toggleSelectAll(bool? isSelected) {
    if (isSelected == true) {
      _selectedItemIds = _participants.map((p) => p.id.toString()).toSet();
    } else {
      _selectedItemIds.clear();
    }
    notifyListeners();
  }

  bool isItemSelected(ParticipantModel participant) {
    return _selectedItemIds.contains(participant.id.toString());
  }

  Future<void> fetchParticipants(
      String? name, String? idNumber, int currentPage, int pageSize) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await participantService.getParticipants(
          name, idNumber, currentPage, pageSize);
      if (result is ResponseModel<ParticipantModel>) {
        _participants = result.items;
        _total = result.total;
        _selectedItemIds.clear();
      } else if (result is ErrorResponseModel) {
        _participants = [];
        _total = 0;
        throw Exception(
            'Failed to fetch participants: ${result.errors['error'] ?? 'Unknown error'}');
      } else {
        _participants = [];
        _total = 0;
        throw Exception(
            'Failed to fetch participants: Unexpected response type');
      }
    } catch (e) {
      _participants = [];
      _total = 0;
      throw Exception('Failed to fetch participants: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
