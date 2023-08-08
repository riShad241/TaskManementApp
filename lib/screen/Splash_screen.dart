import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_todo/Widget/background_widget.dart';
import 'package:real_todo/data/models/auth_utility.dart';
import 'package:real_todo/utilits/assets_utilits.dart';
import '';
import 'auth/Login_Screen.dart';
import 'bottom_nav_base_screen.dart';
class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  void initState() {
    super.initState();
    navigatorToLogin();
  }
  void navigatorToLogin(){
    Future.delayed(Duration(seconds: 3)).then((value) async {
      final bool islogged = await AuthUtilits.cheakIfuserInfo();
      if (mounted) {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) =>
      islogged ? const BottomNavbaseScreen() : const LogIn_screen(

      )), (route) => false);
    }
    });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackgroud(child:  Center(
        child: SvgPicture.asset(utility.logo,width: 90,),
      ))
    );
  }
}
