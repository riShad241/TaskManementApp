import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_todo/Widget/background_widget.dart';
import '../../data/models/Network_response.dart';
import '../../data/services/network_caller.dart';
import '../../utils/url-.dart';
import 'Login_Screen.dart';
import 'otp_validation.dart';
class EmailVarificationScreen extends StatefulWidget {
  const EmailVarificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVarificationScreen> createState() => _EmailVarificationScreenState();
}

class _EmailVarificationScreenState extends State<EmailVarificationScreen> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTEController = TextEditingController();

  Future<void> sendPinToEmail() async {
    if(!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();

    _isLoading = true;
    if(mounted) {
      setState(() {});
    }

    final String responseUrl = Urls.recoveryEmailUrl + _emailTEController.text;
    final NetworkResponse response = await NetworkCaller().getRequest(responseUrl);

    Map<String, dynamic> decodedResponse = jsonDecode(jsonEncode(response.body));

    _isLoading = false;
    if(mounted) {
      setState(() {});
    }

    if(response.issuccess && mounted) {
      if(decodedResponse['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Verification mail sent. Kindly check your email.'),

        ));

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => otp_varification(emailAddress: _emailTEController.text)
            ));
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('User not found!'),
          backgroundColor: Colors.red,
        ));
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed sending email!'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Email Address',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 6,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'A 6 digit verification pin will send to your email address',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailTEController,
                  decoration: const InputDecoration(
                      hintText: 'Email', labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter Email!';
                    }
                    return null;
                  },
                  onEditingComplete: sendPinToEmail,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Visibility(
                visible: _isLoading == false,
                child:
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: sendPinToEmail,
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),

              ),
              signInButton(context)
            ],
          ),
        ),
      ),
    ));
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