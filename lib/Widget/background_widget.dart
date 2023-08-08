import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_todo/utilits/assets_utilits.dart';
class ScreenBackgroud extends StatelessWidget {
  final Widget child;
  const ScreenBackgroud({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SvgPicture.asset(utility.background,fit: BoxFit.cover,),
        ),
        child
      ],
    );
  }
}