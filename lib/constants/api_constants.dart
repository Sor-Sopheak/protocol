class ApiConstants {
  static const String baseUrl = 'http://172.23.14.228:8000';

  //Auth Routes
  static const String loginEndpoint = '/user/login';

  //Auth Uri
  static Uri loginUri() => Uri.parse('$baseUrl$loginEndpoint');

  //Event Routes
  static const String eventListEndpoint = '/event/list_events';

  static Uri getListEventsUri() => Uri.parse('$baseUrl$eventListEndpoint');
}
