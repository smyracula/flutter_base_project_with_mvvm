import 'package:flutter/material.dart';
import 'package:flutter_base_project_with_mvvm/datamanager/app_preferences.dart';

import 'app_routes.dart';

class App extends StatelessWidget {
  static final App _instance = App._internal();

  App._internal();

  factory App() => _instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: getAppRoutes().getRoutes,
    );
  }

  /*
  *
  *
  * void handleTimeout()async {

    await App().getAppPreferences().isPreferenceReady;

    App().getAppPreferences().getLoggedIn().then((isLoggedIn) {
      isLoggedIn
          ? Navigator.pushReplacementNamed(context, AppRoutes.APP_ROUTE_DASHBOARD)
          : Navigator.pushReplacementNamed(context, AppRoutes.APP_ROUTE_LOGIN);
    });
  }
  *
  *
  * */
  AppRoutes getAppRoutes() {
    return AppRoutes();
  }

  AppPreferences getAppPreferences() {
    return AppPreferences();
  }

  LoginRepository getLoginRepository(
      {@required AppPreferences appPreferences}) {
    return LoginRepository(appPreferences: appPreferences);
  }

  RegisterRepository getRegisterRepository(
      {@required AppPreferences appPreferences}) {
    return RegisterRepository(appPreferences: appPreferences);
  }
}
