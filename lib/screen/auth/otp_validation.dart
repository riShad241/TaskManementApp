import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:real_todo/Widget/background_widget.dart';
import 'package:real_todo/screen/auth/resat_password.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../data/models/Network_response.dart';
import '../../data/services/network_caller.dart';
import '../../utils/url-.dart';
import 'Login_Screen.dart';
class otp_varification extends StatefulWidget {
  const otp_varification({super.key, required this.emailAddress});

  final String emailAddress;

  @override
  State<otp_varification> createState() => _otp_varificationState();
}

class _otp_varificationState extends State<otp_varification> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _pinCodeTEController = TextEditingController();

  Future<void> verifyEmailWithPin() async {
    if(!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();

    _isLoading = true;
    if(mounted) {
      setState(() {});
    }

    final String responseUrl = Urls.recoveryOTPUrl + widget.emailAddress + '/'+ _pinCodeTEController.text;
    final NetworkResponse response = await NetworkCaller().getRequest(responseUrl);

    log(responseUrl);

    _isLoading = false;
    if(mounted) {
      setState(() {});
    }

    if(_pinCodeTEController.value.text.length == 6 && mounted) {
      Map<String, dynamic> decodedResponse = jsonDecode(jsonEncode(response.body));
      if(response.issuccess) {
        if(decodedResponse['status'] == 'success') {

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Set new password'),
          ));

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Resat_password(
                  emailAddress: widget.emailAddress,
                  otpCode: _pinCodeTEController.text,
                )), (route) => false,
          );
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Pin code didn't match. Try again!"),
            backgroundColor: Colors.red,
          ));
        }
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Verification Error!'),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Fill full code!'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackgroud(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PIN Verification',
                  style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                  const SizedBox(height: 6,),
                  const Text('A 6 digit verification pin will send to your email address',
                   style: TextStyle(fontSize: 15,color: Colors.grey),
                  ),
                  const SizedBox(height: 16,),
                  Form(
                    key: _formKey,
                    child: PinCodeTextField(
                      controller: _pinCodeTEController,
                      appContext: context,
                      length: 6,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          borderWidth: 0.5,
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white
                      ),
                      backgroundColor: Colors.white,
                      animationType: AnimationType.scale,
                      onEditingComplete: verifyEmailWithPin,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Visibility(
                    visible: _isLoading == false,
                    child:
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: verifyEmailWithPin,
                            child: const Text('Verify'),
                          ),
                        ),
                  ),
                  signInButton(context)
                ],
              ),
            ),
          ),
        )
    );
  }

  Row signInButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Have account? "),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Sign In'),
        ),
      ],
    );
  }
}