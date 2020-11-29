import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:revive/models/response/login/response_login.dart';
import 'package:revive/utils/network_utils.dart';

import '../network_config.dart';
import '../network_endpoints.dart';

class LoginNAO {
  static Future<ResponseLogin> login(
          {@required String email, @required String password}) =>
      NetworkUtil().post(
          url: NetworkEndpoints.LOGIN_API,
          body: jsonEncode({'email': email, 'password': password}),
          headers: NetworkConfig.headers
          //jsonEncode(RequestLogin(email: email, password: password)
          ).then((dynamic response) {
        print(response);
        return ResponseLogin.fromJson(response);
      });
}
