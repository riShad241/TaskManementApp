import 'package:flutter/material.dart';
import 'package:real_todo/Widget/background_widget.dart';
import 'package:real_todo/screen/auth/resat_password.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'Login_Screen.dart';
class Otp_validation extends StatelessWidget {
  const Otp_validation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ScreenBackgroud(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 64,),
                  Text('PIN Verification',style:  Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 4,),
                  Text("A 6 digit pin will sent to your email address",
                    style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey),
                    ),
                  const SizedBox(height: 15,),
                  PinCodeTextField(
                    keyboardType: TextInputType.number,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.red,
                      activeColor: Colors.white,
                      selectedFillColor: Colors.white,
                      selectedColor: Colors.green,

                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.white,
                    enableActiveFill: true,
                    cursorColor: Colors.green,
                    enablePinAutofill: true,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    }, appContext: context,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Resat_password()),
                                (route) => false);
                      }, child: Text("Verify"))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account"),
                      TextButton(onPressed: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LogIn_screen()),
                              (route) => false);}, child: const Text("Sing in"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
