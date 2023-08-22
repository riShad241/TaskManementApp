import 'dart:convert';

import 'package:flutter/material.dart';
import '../../Widget/background_widget.dart';
import '../../data/models/Network_response.dart';
import '../../data/services/network_caller.dart';
import '../../utils/url-.dart';
import 'Login_Screen.dart';
class Resat_password extends StatefulWidget {
  const Resat_password({Key? key, required this.emailAddress, required this.otpCode}) : super(key: key);
  final String emailAddress,otpCode;

  @override
  State<Resat_password> createState() => _Resat_passwordState();
}

class _Resat_passwordState extends State<Resat_password> {

  bool _isLoading  = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  Future<void> postNewPassword() async {
    if(!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();

    _isLoading = true;
    if(mounted) {
      setState(() {});
    }

    Map<String,dynamic> requestBody = {
      "email":widget.emailAddress,
      "OTP":widget.otpCode,
      "password":_confirmPasswordTEController.text
    };
    final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.setPasswordUrl, requestBody
    );
    Map<String, dynamic> decodedResponse = jsonDecode(jsonEncode(response.body));

    _isLoading = false;
    if(mounted) {
      setState(() {});
    }

    if(response.issuccess && mounted) {
      if(decodedResponse['status'] == 'success') {
        _passwordTEController.clear();
        _confirmPasswordTEController.clear();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Password reset successful.'),
        ));

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LogIn_screen()
            ));
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid request!"),
          backgroundColor: Colors.red,
        ));
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Set password error!'),
        backgroundColor: Colors.red,
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackgroud(child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50,),
                Text("Set Password",style: Theme.of(context).textTheme.titleLarge,),
                const SizedBox(height: 5,),
                Text("Minimum Password should be 8 letter with number & symbols",
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: Colors.grey)),
                const SizedBox(height: 24,),
                TextFormField(
                  controller: _passwordTEController,
                  obscureText: true,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your password!';
                    }
                    if (value!.length < 8) {
                      return 'password length must be 8 or more';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _confirmPasswordTEController,
                  obscureText: true,
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      return 'Enter Confirm password';
                    }if(value! != _passwordTEController.text){
                      return "Password did't match!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Confirm Password",
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _isLoading == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(onPressed: (){
                        postNewPassword();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const LogIn_screen()));
                      }, child:  const Text('Confirm')),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have an account?"),
                    TextButton(onPressed: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const LogIn_screen()),
                            (route) => false);}, child: const Text("Sing in"))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}