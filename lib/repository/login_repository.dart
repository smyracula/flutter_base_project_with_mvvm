import 'dart:async';

import 'package:meta/meta.dart';
import 'package:revive/datamanager/app_preferences.dart';
import 'package:revive/network/nao/login_nao.dart';

class LoginRepository {
  var _isSuccessfulLogin = StreamController<bool>.broadcast();
  var _errorMessageLogin = StreamController<String>.broadcast();
  AppPreferences _appPreferences;

  factory LoginRepository({@required AppPreferences appPreferences}) =>
      LoginRepository._internal(appPreferences);

  LoginRepository._internal(this._appPreferences);

  void login({@required String email, @required String password}) {
    LoginNAO.login(email: email, password: password).then((response) {
      if (response.isSuccess == true) {
        _isSuccessfulLogin.add(true);
        _appPreferences.setLoggedIn(isLoggedIn: true);
      } else {
        _isSuccessfulLogin.add(false);
        _errorMessageLogin.add(response.message);
        _appPreferences.setLoggedIn(isLoggedIn: false);
      }
    });
  }

  Stream<bool> getLoginResponse() {
    return _isSuccessfulLogin.stream;
  }

  Stream<String> getLoginErrorMessage() {
    return _errorMessageLogin.stream;
  }
}
