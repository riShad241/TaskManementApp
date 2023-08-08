import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:real_todo/MyApp.dart';
import 'package:real_todo/data/models/Network_response.dart';
import 'package:real_todo/data/models/auth_utility.dart';

import '../../screen/auth/Login_Screen.dart';


class NetworkCaller {
  Future<NetworkResponse> getRequest(String url) async{
    try{
      Response response = await get(Uri.parse(url),headers: {
        'token' : AuthUtilits.userinfo.token.toString()
      });
      if(response.statusCode == 200){
       return NetworkResponse(true,response.statusCode, jsonDecode(response.body));
      }else{
        return NetworkResponse(false,response.statusCode,null);
      }
    } catch(e){
      log(e.toString() as num);
    }
    return NetworkResponse(false,-1,null);
  }
  Future<NetworkResponse> postRequest(String url,Map<String, dynamic> body) async{
    try{
      Response response = await post(Uri.parse(url),
          headers: {
        'Content-Type': 'application/json',
         'token' : AuthUtilits.userinfo.token.toString()
          },
          body:  jsonEncode(body));
      if(response.statusCode == 200){
        return NetworkResponse(true,response.statusCode, jsonDecode(response.body));
      }  else if(response.statusCode == 401){

      }
        else{
        return NetworkResponse(false,response.statusCode,null);
      }
    } catch(e){
      log(e.toString() as num);
    }
    return NetworkResponse(false,-1,null);
  }
  Future<void> gotoLogin() async {
    await AuthUtilits.clearUserInfo();
     Navigator.pushAndRemoveUntil(MyApp.globalKey.currentContext!, MaterialPageRoute(builder: (context)=>const LogIn_screen()), (route) => false);
  }
}