import 'package:flutter/material.dart';
import 'package:real_todo/data/models/Network_response.dart';
import 'package:real_todo/data/services/network_caller.dart';
import 'package:real_todo/utils/url-.dart';

import '../../Widget/background_widget.dart';
import 'Login_Screen.dart';
class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _firstNameTEcontroller = TextEditingController();
  final TextEditingController _LastnameTEcontroller = TextEditingController();
  final TextEditingController _mobileTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void> userSingup() async{
    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.registration, <String, dynamic>{
      "email": _emailTEcontroller.text.trim(),
      "firsName": _firstNameTEcontroller.text.trim(),
      "lastName": _LastnameTEcontroller.text.trim(),
      "mobile": _mobileTEcontroller.text.trim(),
      "password": _passwordTEcontroller.text,
      "photo":""
    });
    if(response.issuccess){
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration Success")));
      }
    }else{
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration Failed")));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackgroud(child:
      SafeArea (
        child: Center(child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("Join with us",style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _emailTEcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration:const InputDecoration(
                      hintText: "Email",
                    ),
                    validator:  (String? value){
                      if(value?.isEmpty ?? true){
                        return 'Enter your Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _firstNameTEcontroller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                     hintText: "First Name",
                    ),
                    validator:  (String? value){
                      if(value?.isEmpty ?? true){
                        return 'Enter your First Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                     controller: _LastnameTEcontroller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Last Name",
                    ),
                    validator:  (String? value){
                      if(value?.isEmpty ?? true){
                        return 'Enter your LastName';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _mobileTEcontroller,
                    keyboardType: TextInputType.phone,
                    decoration:const InputDecoration(
                      hintText: "Mobile ",
                    ),
                    validator:  (String? value){
                      if((value?.isEmpty ?? true) || value!.length < 11){
                        return 'Enter your Valid Number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: _passwordTEcontroller,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    validator:  (String? value){
                      if((value?.isEmpty ?? true) || value!.length <= 5){
                        return 'Enter your Password';
                      }
                      return null;
                    },
                  ),
                   const SizedBox(height: 16,),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: (){
                        if(!_formkey.currentState!.validate()) {
                          return;
                        }
                        userSingup();
                      },
                          child: const Icon(Icons.arrow_circle_right_outlined))),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have an account ?"),
                      TextButton(onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LogIn_screen()),
                                (route) => false);
                      }, child: const Text("Sing in"))
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
      ),),
    );
  }
}
