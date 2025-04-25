import 'package:flutter/foundation.dart';
import 'package:protocol_app/models/responses/error_response_model.dart';
import 'package:protocol_app/models/responses/response_model.dart';
import 'package:protocol_app/models/user_model.dart';
import 'package:protocol_app/services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService userService;
  UserProvider({required this.userService});

  bool _isLoading = true;
  List<UserModel> _users = [];
  int _total = 0;

  bool get isLoading => _isLoading;
  List<UserModel> get users => _users;
  int get total => _total;

  Future<void> fetchUsers(
    String? keyword,
    int currentPage,
    int pageSize,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result =
          await userService.fetchUsers(keyword, currentPage, pageSize);

      if (result is ResponseModel<UserModel>) {
        _users = result.items; print('Users: $_users');
        _total = result.total;
      } else if (result is ErrorResponseModel) {
        _users = [];
        _total = 0;
        debugPrint('Error fetching users: ${result.errors}');
      }
    } catch (e) {
      _users = [];
      _total = 0;
      debugPrint('Exception fetching users: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
