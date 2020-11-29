import 'package:flutter/material.dart';
import 'package:flutter_base_project_with_mvvm/app/app_routes.dart';
import 'package:flutter_base_project_with_mvvm/helpers/UIHelper.dart';
import 'package:flutter_base_project_with_mvvm/resources/value/app_colors.dart';
import 'package:flutter_base_project_with_mvvm/resources/value/app_strings.dart';
import 'package:flutter_base_project_with_mvvm/resources/value/app_styles.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(UIHelper.intro_bg), fit: BoxFit.fill),
            ),
            child: Center(
                child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(15.0),
                    children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),
                    child: Text(
                      AppStrings.INTRO_HEADER,
                      style: AppStyles.headerTextStyle,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Center(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                        child: SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.WHITE),
                                borderRadius: new BorderRadius.circular(8.0)),
                            child: RaisedButton(
                              color: AppColors.TRANSPARENT,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                AppStrings.LOGIN_LOGIN_BUTTON,
                                style: AppStyles.buttonStyle,
                              ),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FlatButton(
                    child: Text("Skip",
                        style: AppStyles.textButtonTextStyle,
                        textAlign: TextAlign.center),
                    color: AppColors.TRANSPARENT,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(context, AppRoutes.APP_ROUTE_HOME);
                    },
                  )
                ]))));
  }
}
