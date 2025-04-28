import 'package:universal_html/html.dart';

class AuthHelper {
  static Storage localStorage = window.localStorage;
  static Storage sessionStorage = window.sessionStorage;

  //local storage
  static void saveToLocalStorage(String key, String value) {
    localStorage[key] = value;
  }

  static String? getValueFromLocalStorage(String key) {
    return localStorage[key];
  }

  static void removeFromLocalStorage(String key) {
    localStorage.remove(key);
  }

  static void clearAllLocalStorage() {
    localStorage.clear();
  }

  //session storage
  static void saveToSessionStorage(String key, String value) {
    sessionStorage[key] = value;
  }

  static String? getValueFromSessionStorage(String key) {
    return sessionStorage[key];
  }

  static void removeFromSessionStorage(String key) {
    sessionStorage.remove(key);
  }

  static void clearAllSessionStorage() {
    sessionStorage.clear();
  }
}
