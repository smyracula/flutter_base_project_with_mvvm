import 'package:flutter/material.dart';

class AppRoutes{

  static const String APP_ROUTE_INTRO = "/intro";
  static const String APP_ROUTE_HOME = "/home";

  Route getRoutes(RouteSettings routeSettings){

    print("getRoutes");
    switch(routeSettings.name){

      case APP_ROUTE_INTRO : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => IntroScreen(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_HOME : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => HomeScreen(),
        );
      }

      default: {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => IntroScreen(),
          fullscreenDialog: true,
        );
      }
    }
  }

}



