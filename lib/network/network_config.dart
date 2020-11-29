import 'dart:io';

class NetworkConfig {
  /// Login API Keys
  static const String API_KEY_USER_NAME = "userName";
  static const String API_KEY_USER_PASSWORD = "userPassword";
  static const String API_KEY_LOGIN_RESPONSE = "response";

  static const Map<String, String> headers = {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json'
  };
}
