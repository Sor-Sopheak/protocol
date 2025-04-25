class ApiConstants {
  static const String baseUrl = 'http://172.23.14.228:8000';

  static const String eventListEndpoint = '/event/list_events';

  static Uri getListEventsUri() => Uri.parse('$baseUrl$eventListEndpoint');
}
