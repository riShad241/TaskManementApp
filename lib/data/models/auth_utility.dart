import 'dart:convert';

import 'package:real_todo/data/models/loginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthUtilits{
  AuthUtilits._();

  static LoginModel userinfo = LoginModel();
  static Future<void> saveUserInfo(LoginModel model) async{
    SharedPreferences _shearpfe = await SharedPreferences.getInstance();
    await _shearpfe.setString('user-data', jsonEncode(model.toJson()));
    userinfo = model;
  }
  static Future<void> UpdateUserInfo(UserData data) async{
    SharedPreferences _shearpfe = await SharedPreferences.getInstance();
    userinfo.data = data;
    await _shearpfe.setString('user-data', jsonEncode(userinfo.toJson()));
  }
  static Future<LoginModel> getuserInfo() async{
    SharedPreferences _shearpfe = await SharedPreferences.getInstance();
    String value = _shearpfe.getString('user-data')!;
    return LoginModel.fromJson(jsonDecode(value));
  }
  static Future<void> clearUserInfo() async{
    SharedPreferences _shearpfe = await SharedPreferences.getInstance();
    await _shearpfe.clear();
  }
  static Future<bool> cheakIfuserInfo()async{
    SharedPreferences _shearpfe = await SharedPreferences.getInstance();
    bool isLogin = _shearpfe.containsKey('user-data');
    if(isLogin){
      userinfo = await getuserInfo();
    }
    return isLogin;
  }
}