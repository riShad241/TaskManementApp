import 'package:flutter/material.dart';

import '../Widget/UserprofileBaner.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const userProfileBanare(),
            Center(child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Text("Update Profile",style: Theme.of(context).textTheme.titleLarge,),
                    const SizedBox(height: 16,),
                    Row(
                      children: [
                        PhotoTest(),
                        Container(
                          height: 57,
                          width: 273,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "First Name",
                      ),
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Last Name",
                      ),
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Mobile ",
                      ),
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: (){
                        }, child: const Icon(Icons.arrow_circle_right_outlined))),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class PhotoTest extends StatelessWidget {
  const PhotoTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black38
      ),
      child: Center(child: const Text('Photos',style: TextStyle(color: Colors.white),)),
    );
  }
}

