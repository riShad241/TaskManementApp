import 'package:flutter/material.dart';
import '../../Widget/background_widget.dart';
import 'Login_Screen.dart';
class Resat_password extends StatelessWidget {
  const Resat_password({Key? key}) : super(key: key);

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
              Text("Set Password",style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(height: 5,),
              Text("Minimum Password should be 8 letter with number & symbols",
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey)),
              const SizedBox(height: 24,),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LogIn_screen()));
                  }, child:  Text('Confirm'))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Have an account?"),
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
