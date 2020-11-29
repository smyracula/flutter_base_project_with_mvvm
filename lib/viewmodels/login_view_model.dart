import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:revive/app/app.dart';
import 'package:revive/observers/login_observer.dart';
import 'package:revive/repository/login_repository.dart';

class LoginViewModel {
  LoginObserver _loginObserver;
  LoginRepository _loginRepository;
  static LoginViewModel _instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var _loginResponseController = StreamController<bool>.broadcast();
  var _loginResponseErrorController = StreamController<String>.broadcast();

  factory LoginViewModel(App app) {
    _instance ??= LoginViewModel._internal(
        loginObserver: LoginObserver(),
        loginRepository:
            app.getLoginRepository(appPreferences: app.getAppPreferences()));

    return _instance;
  }

  LoginViewModel._internal(
      {@required LoginObserver loginObserver,
      @required LoginRepository loginRepository}) {
    _loginObserver = loginObserver;

    _loginRepository = loginRepository;

    _init();
  }

  void _init() {
    emailController
        .addListener(() => getLoginObserver().email.add(emailController.text));

    passwordController.addListener(
        () => getLoginObserver().password.add(passwordController.text));

    _listenLoginResponse();
    _listenLoginErrorResponse();
  }

  void _listenLoginResponse() {
    _loginRepository.getLoginResponse().listen((isSuccessfulLogin) {
      if (isSuccessfulLogin) {
        _loginObserver.dispose();
        _loginResponseController.add(true);
      } else {
        //_loginObserver.invalidCredentials();
        _loginResponseController.add(false);
      }
    });
  }

  void _listenLoginErrorResponse() {
    _loginRepository.getLoginErrorMessage().listen((message) {
      if (message != null) {
        _loginResponseErrorController.add(message);
      }
    });
  }

  LoginObserver getLoginObserver() => _loginObserver;

  void checkLogin({@required String email, @required String password}) {
    _loginRepository.login(email: email, password: password);
  }

  Stream<bool> getLoginResponse() => _loginResponseController.stream;

  Stream<String> getLoginResponseMessage() =>
      _loginResponseErrorController.stream;
}
