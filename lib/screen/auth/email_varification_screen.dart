import 'package:flutter/material.dart';
import 'package:real_todo/Widget/background_widget.dart';
import 'Login_Screen.dart';
import 'otp_validation.dart';
class EmailVarificationScreen extends StatelessWidget {
  const EmailVarificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackgroud(child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Text("Your email address",style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(height: 5,),
              Text("A 6 digits pin will  sent to your email address",
              style: Theme.of(context).textTheme.bodyMedium,),
              const SizedBox(height: 24,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Otp_validation()));
                  }, child: Icon(Icons.arrow_circle_right_outlined))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account"),
                  TextButton(onPressed: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LogIn_screen()),
                          (route) => false);}, child: const Text("Sing in"))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
