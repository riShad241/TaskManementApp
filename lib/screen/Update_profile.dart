import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_todo/Widget/background_widget.dart';
import 'package:real_todo/data/models/Network_response.dart';
import 'package:real_todo/data/models/auth_utility.dart';
import 'package:real_todo/data/models/loginModel.dart';
import 'package:real_todo/data/services/network_caller.dart';
import 'package:real_todo/utils/url-.dart';

import '../Widget/UserprofileBaner.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  UserData userData = AuthUtilits.userinfo.data!;
  final TextEditingController _emailTEcontroller = TextEditingController();

  final TextEditingController _firstNameTEcontroller = TextEditingController();

  final TextEditingController _LastnameTEcontroller = TextEditingController();

  final TextEditingController _mobileTEcontroller = TextEditingController();

  final TextEditingController _passwordTEcontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  XFile? imageFile;
  ImagePicker picker = ImagePicker();
  bool _profileInprogress = false;

  @override
  void initState() {
    super.initState();
    _emailTEcontroller.text = userData?.email ?? '';
    _firstNameTEcontroller.text = userData?.firstName ?? '';
    _LastnameTEcontroller.text = userData?.lastName ?? '';
    _mobileTEcontroller.text = userData?.mobile ?? '';
  }

  Future<void> profileUpdate() async {
    _profileInprogress = true;
    if (mounted) {
      setState(() {});
    }
    final Map<String, dynamic> requestBody = {
      'firstName ': _firstNameTEcontroller.text.trim(),
      'lastName ': _LastnameTEcontroller.text.trim(),
      'mobile ': _mobileTEcontroller.text.trim(),
      'photo ': '',
    };
    if (_passwordTEcontroller.text.isNotEmpty) {
      requestBody['password'] = _passwordTEcontroller.text;
    }
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, requestBody);
    _profileInprogress = false;
    if (mounted) {
      setState(() {});
    }
    if(response.issuccess){
      userData.firstName = _firstNameTEcontroller.text.trim();
      userData.lastName = _LastnameTEcontroller.text.trim();
      userData.mobile = _mobileTEcontroller.text.trim();
      AuthUtilits.UpdateUserInfo(userData);
      _passwordTEcontroller.clear();
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('profile update')));
      }
    }else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('profile update failed plz try again')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackgroud(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const userProfileBanare(
                    isupdateScreen: true,
                  ),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Update Profile",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              PhotoTest(),
                              InkWell(
                                onTap: () {
                                  selectImage();
                                },
                                child: Container(
                                  height: 57,
                                  width: 273,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: Visibility(
                                      visible: imageFile != null,
                                      child: Text(imageFile?.name ?? '')),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _emailTEcontroller,
                            readOnly: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Email",
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _firstNameTEcontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "First Name",
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _LastnameTEcontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Last Name",
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            readOnly: true,
                            controller: _mobileTEcontroller,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: "Mobile ",
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _passwordTEcontroller,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Password",
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: _profileInprogress
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        profileUpdate();
                                      },
                                      child: const Icon(
                                          Icons.arrow_circle_right_outlined))),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void selectImage() {
    picker.pickImage(source: ImageSource.gallery).then((XFile) {
      if (XFile != null) {
        imageFile = XFile;
        if (mounted) {
          setState(() {});
        }
      }
    });
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
          borderRadius: BorderRadius.circular(5), color: Colors.black38),
      child: Center(
          child: const Text(
        'Photos',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
