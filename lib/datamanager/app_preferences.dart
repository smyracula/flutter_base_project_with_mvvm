import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class AppPreferences{

  static const String PREF_TYPE_BOOL = "BOOL";
  static const String PREF_TYPE_INTEGER = "INTEGER";
  static const String PREF_TYPE_DOUBLE = "DOUBLE";
  static const String PREF_TYPE_STRING = "STRING";

  static const String PREF_IS_LOGGED_IN = "IS_LOGGED_IN";

  Future _isPreferenceInstanceReady;

  SharedPreferences _preferences;

  static final AppPreferences _instance = AppPreferences._internal();

  factory AppPreferences()=> _instance;

  AppPreferences._internal(){
    _isPreferenceInstanceReady = SharedPreferences.getInstance().then((preferences)=> _preferences = preferences);
  }

  Future get isPreferenceReady => _isPreferenceInstanceReady;

  void setLoggedIn({@required bool isLoggedIn}) => _setPreference(prefName: PREF_IS_LOGGED_IN, prefValue: isLoggedIn, prefType: PREF_TYPE_BOOL);

  Future<bool> getLoggedIn() async => await _getPreference(prefName: PREF_IS_LOGGED_IN) ?? false;

  void _setPreference ({@required String prefName,@required dynamic prefValue,@required String prefType}){
    switch(prefType){
      case PREF_TYPE_BOOL:{
        _preferences.setBool(prefName, prefValue);
        break;
      }
      case PREF_TYPE_INTEGER:{
        _preferences.setInt(prefName, prefValue);
        break;
      }
      case PREF_TYPE_DOUBLE:{
        _preferences.setDouble(prefName, prefValue);
        break;
      }
      case PREF_TYPE_STRING:{
        _preferences.setString(prefName, prefValue);
        break;
      }
    }

  }

  Future<dynamic> _getPreference({@required prefName}) async => _preferences.get(prefName);

}
