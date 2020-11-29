import 'dart:async';

import 'package:revive/ui/ui_helper.dart';

abstract class LoginObserverContract {
  static const int USER_NAME_VALID_LENGTH = 3;
  static const int USER_PASSWORD_VALID_LENGTH = 4;

  Sink get email;

  Sink get password;

  Stream<bool> get _isValidEmail;

  Stream<bool> get _isValidPassword;

  Stream<bool> get isLoginEnabled;

  Stream<String> get emailErrorText;

  Stream<String> get passwordErrorText;

  LoginObserverContract() {
    _init();
  }

  void dispose();

  void invalidCredentials();

  void _init() {
    _handleLoginEnableProcess();
  }

  void _handleLoginEnableProcess();

  bool _checkValidEmail(String email);

  bool _checkValidPassword(String password);
}

class LoginObserver extends LoginObserverContract {
  var _emailController = StreamController<String>.broadcast();
  var _passwordController = StreamController<String>.broadcast();
  var _emailErrorMsgController = StreamController<String>.broadcast();
  var _passwordErrorMsgController = StreamController<String>.broadcast();
  var _isLoginValidToggleController = StreamController<bool>.broadcast();
  bool _tempValidEmail, _tempValidPassword;

  LoginObserver() : super();

  @override
  void _init() {
    super._init();
    _tempValidEmail = _tempValidPassword = false;
  }

  @override
  void _handleLoginEnableProcess() {
    _isValidEmail.listen((isValidEmail) {
      if (isValidEmail) {
        _tempValidEmail = true;
        _tempValidPassword ? _isLoginValidToggleController.add(true) : null;
        _emailErrorMsgController.add(null);
      } else {
        // Invalid User Name
        // Set temporary valid user name to FALSE i.e. set it invalid
        _tempValidEmail = false;
        // Add FALSE event to isLoginValidToggle stream
        _isLoginValidToggleController.add(false);
        // ADD user name error string event to userNameErrorMsg stream
        _emailErrorMsgController.add(UIHelper.emailNotValid);
      }
    });

    _isValidPassword.listen((isValidPassword) {
      if (isValidPassword) {
        _tempValidPassword = true;
        _tempValidEmail ? _isLoginValidToggleController.add(true) : null;
        _passwordErrorMsgController.add(null);
      } else {
        _tempValidPassword = false;
        _isLoginValidToggleController.add(false);
        _passwordErrorMsgController.add(UIHelper.passwordNotValid);
      }
    });
  }

  @override
  Stream<bool> get _isValidEmail => _emailController.stream
      .skip(LoginObserverContract.USER_NAME_VALID_LENGTH)
      .map(_checkValidEmail);

  @override
  Stream<bool> get _isValidPassword => _passwordController.stream
      .skip(LoginObserverContract.USER_PASSWORD_VALID_LENGTH)
      .map(_checkValidPassword);

  @override
  Stream<bool> get isLoginEnabled => _isLoginValidToggleController.stream;

  @override
  Sink get email => _emailController;

  @override
  Stream<String> get emailErrorText => _emailErrorMsgController.stream;

  @override
  Sink get password => _passwordController;

  @override
  Stream<String> get passwordErrorText => _passwordErrorMsgController.stream;

  @override
  bool _checkValidEmail(String email) =>
      email != null &&
      email.length >= LoginObserverContract.USER_NAME_VALID_LENGTH;

  @override
  bool _checkValidPassword(String password) =>
      password != null &&
      password.length >= LoginObserverContract.USER_PASSWORD_VALID_LENGTH;

  @override
  void invalidCredentials() {
    _emailErrorMsgController.add("AppStrings.LOGIN_USER_NAME_INVALID_MSG");
    _passwordErrorMsgController
        .add("AppStrings.LOGIN_USER_PASSWORD_INVALID_MSG");
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _emailErrorMsgController.close();
    _passwordErrorMsgController.close();
    _isLoginValidToggleController.close();
  }
}
