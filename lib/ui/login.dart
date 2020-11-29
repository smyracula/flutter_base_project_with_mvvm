import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:revive/app/app.dart';
import 'package:revive/app/app_routes.dart';
import 'package:revive/ui/styles/text_styles.dart';
import 'package:revive/ui/ui_helper.dart';
import 'package:revive/ui/widgets/forgetPassButton_widget.dart';
import 'package:revive/view_models/login_view_model.dart';

import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  LoginViewModel _viewModel;
  bool _isLoading;
  bool _passwordVisible;

  @override
  void initState() {
    _viewModel = LoginViewModel(App());
    subscribeToViewModel();
    _isLoading = false;
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: UIHelper.WHITE),
          backgroundColor: UIHelper.BLACK,
          title: Text(
            UIHelper.login,
            style: UITextStyles.loginAppBarTextStyle,
          ),
        ),
        backgroundColor: UIHelper.DARK_GREY,
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                StreamBuilder<String>(
                  // Subscribing to userNameErrorText stream
                  stream: _viewModel.getLoginObserver().emailErrorText,
                  // Building child widget with current 'context' and stream 'snapshot' data
                  builder: (context, snapshot) {
                    // Widget with horizontal padding
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _viewModel.emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: UIHelper.GREY,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              borderSide:
                                  BorderSide(color: UIHelper.GREY, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              borderSide:
                                  BorderSide(color: UIHelper.GREY, width: 2)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 18, 10, 18),
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Sailec',
                            color: UIHelper.GREY_LIGHT,
                          ),
                          hintText: UIHelper.emailHint,
                          errorText: snapshot.data,
                        ),
                        style: UITextStyles.loginEditTextStyle,
                        autocorrect: false,
                        obscureText: false,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder<String>(
                  // Subscribing to userPasswordErrorText stream
                  stream: _viewModel.getLoginObserver().passwordErrorText,
                  // Building child widget with current 'context' and stream 'snapshot' data
                  builder: (context, snapshot) {
                    // Widget with horizontal padding
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),

                      // TextFormField widget for password input
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _viewModel.passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          hintText: UIHelper.password,
                          filled: true,
                          fillColor: UIHelper.GREY,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              borderSide:
                                  BorderSide(color: UIHelper.GREY, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              borderSide:
                                  BorderSide(color: UIHelper.GREY, width: 2)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 18, 10, 18),
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Sailec',
                            color: UIHelper.GREY_LIGHT,
                          ),
                          // Error message => NULL -> No error shown Otherwise Error shown with snapshot.data
                          errorText: snapshot.data,
                          // Suffix icon for password toggle button
                          suffixIcon: IconButton(
                            // Setting Icon widget
                            icon: Icon(
                              // Setting toggle icons based on state of passwordVisible variable
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: UIHelper.GREY_LIGHT,
                            ),
                            onPressed: () {
                              // On pressed toggle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible
                                    ? _passwordVisible = false
                                    : _passwordVisible = true;
                              });
                            },
                          ),
                        ),
                        style: UITextStyles.loginEditTextStyle,
                      ),
                    );
                  },
                ),
                ForgetPasswordButton(
                  color: UIHelper.GREY_LIGHT,
                  rightPadding: 0,
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    );
                  },
                ),
                StreamBuilder(
                  // Subscribing to isLoginEnabled stream
                  stream: _viewModel.getLoginObserver().isLoginEnabled,
                  // Building child widget with current 'context' and stream 'snapshot' data
                  builder: (context, snapshot) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                            height: 56,
                            width: double.infinity,
                            //color: Colors.transparent,
                            decoration: BoxDecoration(
                                color: snapshot.data ?? false
                                    ? UIHelper.WHITE
                                    : UIHelper.GREY,
                                borderRadius: new BorderRadius.circular(4.0)),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(4.0)),
                              child: Text(
                                UIHelper.login,
                                style: TextStyle(
                                    fontFamily: 'Sailec',
                                    fontSize: 17,
                                    color: snapshot.data ?? false
                                        ? UIHelper.GREY
                                        : UIHelper.GREY_LIGHT,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700),
                              ),
                              onPressed: snapshot.data ?? false
                                  ? () {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      _viewModel.checkLogin(
                                          email:
                                              _viewModel.emailController.text,
                                          password: _viewModel
                                              .passwordController.text);
                                    }
                                  : null,
                            )));
                  },
                ),
              ],
            ),
            Visibility(
                visible: _isLoading,
                child: Container(
                  color: UIHelper.DARK_GREY_LOADING,
                  child: Center(
                      child: FadeInImage.assetNetwork(
                    placeholder: cupertinoActivityIndicator,
                    image: "image_1.png",
                    placeholderScale: 4,
                  )),
                )),
          ],
        ));
  }

  void subscribeToViewModel() {
    _viewModel.getLoginResponse().listen((isSuccessfulLogin) {
      setState(() {
        _isLoading = false;
        if (isSuccessfulLogin) {
          Fluttertoast.showToast(msg: UIHelper.loginSuccess);
          Timer(
              const Duration(milliseconds: 300),
              () => Navigator.pushReplacementNamed(
                  context, AppRoutes.APP_ROUTE_HOME));
        }
      });
    });

    _viewModel.getLoginResponseMessage().listen((message) {
      Fluttertoast.showToast(
          msg: message);
    });
  }
}
