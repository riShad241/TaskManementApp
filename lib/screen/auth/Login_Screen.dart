import 'package:flutter/material.dart';
import 'package:real_todo/data/models/Network_response.dart';
import 'package:real_todo/data/models/auth_utility.dart';
import 'package:real_todo/data/models/loginModel.dart';
import 'package:real_todo/data/services/network_caller.dart';
import 'package:real_todo/screen/bottom_nav_base_screen.dart';
import 'package:real_todo/screen/auth/email_varification_screen.dart';
import 'package:real_todo/utils/url-.dart';
import '../../Widget/background_widget.dart';
import 'Signup.dart';
class LogIn_screen extends StatefulWidget {
  const LogIn_screen({Key? key}) : super(key: key);

  @override
  State<LogIn_screen> createState() => _LogIn_screenState();
}

class _LogIn_screenState extends State<LogIn_screen> {
  TextEditingController _EmailTEController = TextEditingController();
  TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _logInprogress = false;
  Future<void> login() async{
    _logInprogress = true;
    if(mounted){
      setState(() {

      });
    }
    Map<String, dynamic> requestBody = {
      "email": _EmailTEController.text.trim(),
      "password": _passwordTEController.text,
    };
    final NetworkResponse response = await NetworkCaller().postRequest(Urls.login, requestBody, isLogin: true);
    _logInprogress = false;
    if(mounted){
      setState(() {

      });
    }
    if(response.issuccess){
      LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtilits.saveUserInfo(model);
        if(mounted){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const BottomNavbaseScreen()),
                  (route) => false);
        }
    }else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Incorrect Email and password")));
      }
    }
  }

 bool istrue = true;
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
                   Text("Get Started With",style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _EmailTEController,
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
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: InputDecoration(
                      suffixIcon: istrue? IconButton(onPressed: () {
                        setState(() {

                        });
                      }, icon:const Icon(Icons.remove_red_eye),):
                      IconButton(onPressed: () {}, icon:const Icon(Icons.remove_red_eye_outlined),),
                      hintText: "Password",
                    ),
                    validator:  (String? value){
                      if(value?.isEmpty ?? true){
                        return 'Enter your valid Password';
                      }
                      return null;
                    },
                  ),
                   const SizedBox(height: 16,),
                  SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _logInprogress == false,
                        replacement: const Center(child: CircularProgressIndicator(),),
                        child: ElevatedButton(onPressed: (){
                          if(!_formkey.currentState!.validate()){
                            return;
                          }
                         login();
                        }, child: const Icon(Icons.arrow_circle_right_outlined)),
                      )),
                  const SizedBox(height: 16,),
                  Center(child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const EmailVarificationScreen()));
                  }, child: const Text('Forget Password',style: TextStyle(color: Colors.grey),))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account"),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Sign_up()));
                      }, child: const Text("Sing Up"))
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
