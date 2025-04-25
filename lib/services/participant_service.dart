import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:protocol_app/models/participant_model.dart';
import 'package:protocol_app/models/responses/error_response_model.dart';
import 'package:protocol_app/models/responses/response_model.dart';

class ParticipantService {
  final http.Client client;
  static final _mockData = {
    'current_page': 1,
    'page_size': 10,
    'total': 3,
    "items": [
      {
        "participant_id": 1,
        "kh_name": "ឧទាហរណ៍ មួយ",
        "en_name": "Example One",
        "gender": "Male",
        "email": "example1@test.com",
        "phone_number": "012345678",
        "department": "IT Department",
        "position": "Software Engineer",
        "id_number": "1234567890",
        "title": "Mr.",
        "level": 1,
        "created_by": "Admin",
        "created_at": "2025-04-25T08:00:00Z",
        "updated_at": "2025-04-25T08:00:00Z"
      },
      {
        "participant_id": 2,
        "kh_name": "ឧទាហរណ៍ ពីរ",
        "en_name": "Example Two",
        "gender": "Female",
        "email": "example2@test.com",
        "phone_number": "098765432",
        "department": "Marketing",
        "position": "Marketing Specialist",
        "id_number": "0987654321",
        "title": "Ms.",
        "level": 2,
        "created_by": "Admin",
        "created_at": "2025-04-25T09:30:00Z",
        "updated_at": "2025-04-25T09:30:00Z"
      },
      {
        "participant_id": 3,
        "kh_name": "ឧទាហរណ៍ បី",
        "en_name": "Example Three",
        "gender": "Male",
        "email": "example3@test.com",
        "phone_number": "011223344",
        "department": "Finance",
        "position": "Accountant",
        "id_number": "1122334455",
        "title": "Mr.",
        "level": 3,
        "created_by": "System",
        "created_at": "2025-04-25T10:15:00Z",
        "updated_at": "2025-04-25T10:15:00Z"
      },
      {
        "participant_id": 4,
        "kh_name": "ឧទាហរណ៍ បួន",
        "en_name": "Example Four",
        "gender": "Female",
        "email": "example4@test.com",
        "phone_number": "077889900",
        "department": "Human Resources",
        "position": "HR Manager",
        "id_number": "7788990011",
        "title": "Mrs.",
        "level": 3,
        "created_by": "Admin",
        "created_at": "2025-04-25T11:00:00Z",
        "updated_at": "2025-04-25T11:00:00Z"
      },
      {
        "participant_id": 5,
        "kh_name": "ឧទាហរណ៍ ប្រាំ",
        "en_name": "Example Five",
        "gender": "Male",
        "email": "example5@test.com",
        "phone_number": "088776655",
        "department": "Sales",
        "position": "Sales Representative",
        "id_number": "8877665544",
        "title": "Mr.",
        "level": 3,
        "created_by": "System",
        "created_at": "2025-04-25T12:30:00Z",
        "updated_at": "2025-04-25T12:30:00Z"
      },
      {
        "participant_id": 6,
        "kh_name": "ឧទាហរណ៍ ប្រាំមួយ",
        "en_name": "Example Six",
        "gender": "Female",
        "email": "example6@test.com",
        "phone_number": "066554433",
        "department": "IT Department",
        "position": "Senior Developer",
        "id_number": "6655443322",
        "title": "Ms.",
        "level": 1,
        "created_by": "Admin",
        "created_at": "2025-04-25T13:15:00Z",
        "updated_at": "2025-04-25T13:15:00Z"
      },
      {
        "participant_id": 7,
        "kh_name": "ឧទាហរណ៍ ប្រាំពីរ",
        "en_name": "Example Seven",
        "gender": "Male",
        "email": "example7@test.com",
        "phone_number": "010998877",
        "department": "Marketing",
        "position": "Marketing Manager",
        "id_number": "1099887766",
        "title": "Mr.",
        "level": 1,
        "created_by": "System",
        "created_at": "2025-04-25T14:00:00Z",
        "updated_at": "2025-04-25T14:00:00Z"
      },
      {
        "participant_id": 8,
        "kh_name": "ឧទាហរណ៍ ប្រាំបី",
        "en_name": "Example Eight",
        "gender": "Female",
        "email": "example8@test.com",
        "phone_number": "078123456",
        "department": "Finance",
        "position": "Financial Analyst",
        "id_number": "7812345609",
        "title": "Ms.",
        "level": 2,
        "created_by": "Admin",
        "created_at": "2025-04-25T14:45:00Z",
        "updated_at": "2025-04-25T14:45:00Z"
      },
      {
        "participant_id": 9,
        "kh_name": "ឧទាហរណ៍ ប្រាំបួន",
        "en_name": "Example Nine",
        "gender": "Male",
        "email": "example9@test.com",
        "phone_number": "097654321",
        "department": "Human Resources",
        "position": "HR Officer",
        "id_number": "9765432108",
        "title": "Mr.",
        "level": 3,
        "created_by": "System",
        "created_at": "2025-04-25T15:30:00Z",
        "updated_at": "2025-04-25T15:30:00Z"
      },
      {
        "participant_id": 10,
        "kh_name": "ឧទាហរណ៍ ដប់",
        "en_name": "Example Ten",
        "gender": "Female",
        "email": "example10@test.com",
        "phone_number": "089123456",
        "department": "Sales",
        "position": "Sales Manager",
        "id_number": "8912345670",
        "title": "Ms.",
        "level": 1,
        "created_by": "Admin",
        "created_at": "2025-04-25T16:15:00Z",
        "updated_at": "2025-04-25T16:15:00Z"
      }
      // You can add 40 more mock participant objects here to reach a total of 50
    ]
  };

  ParticipantService({required this.client});

  Future<dynamic> getParticipants(
    String? name,
    String? idNumber,
    int currentPage,
    int pageSize,
  ) async {
    try {
      final List<dynamic> allItems = _mockData['items'] as List<dynamic>;

      List<dynamic> filteredItems = allItems.where((item) {
        final nameMatch = name == null ||
            (item['en_name'] as String)
                .toLowerCase()
                .contains(name.toLowerCase()) ||
            (item['kh_name'] as String)
                .toLowerCase()
                .contains(name.toLowerCase());
        final idNumberMatch = idNumber == null ||
            (item['id_number'] as String).toLowerCase() ==
                idNumber.toLowerCase();
        return nameMatch && idNumberMatch;
      }).toList();

      final startIndex = (currentPage - 1) * pageSize;
      final endIndex = startIndex + pageSize;
      final paginatedItems = filteredItems.sublist(
        startIndex < filteredItems.length ? startIndex : 0,
        endIndex < filteredItems.length ? endIndex : filteredItems.length,
      );

      final responseData = {
        'current_page': currentPage,
        'page_size': pageSize,
        'total': filteredItems.length,
        'items': paginatedItems,
      };
      return ResponseModel<ParticipantModel>.fromJson(
        responseData,
        (itemJson) => ParticipantModel.fromJson(itemJson),
      );
    } catch (e) {
      return ErrorResponseModel(
        errors: {'error': e.toString()},
        status: false,
      );
    }
  }

  Future<dynamic> createParticipant(ParticipantModel participant) async {
    final body = jsonEncode({
      'kh_name': participant.khName,
      'en_name': participant.enName,
      'gender': participant.gender,
      'email': participant.email,
      'phone_number': participant.phoneNumber,
      'department': participant.department,
      'position': participant.position,
      'id_number': participant.idNumber,
      'title': participant.title,
      'level': participant.level,
    });
  }
}
