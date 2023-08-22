import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_todo/data/models/auth_utility.dart';

import 'package:real_todo/screen/Update_profile.dart';
import 'package:real_todo/screen/auth/Login_Screen.dart';

class userProfileBanare extends StatefulWidget {
  final bool? isupdateScreen;

  const userProfileBanare({
    super.key,
    this.isupdateScreen,
  });

  @override
  State<userProfileBanare> createState() => _userProfileBanareState();
}

class _userProfileBanareState extends State<userProfileBanare> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      //
      actions: [
        IconButton(
            onPressed: () async {
              await AuthUtilits.clearUserInfo();
              if (mounted) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn_screen()),
                    (route) => false);
              }
            },
            icon: Icon(Icons.logout_outlined))
      ],
      title: GestureDetector(
        onTap: (){
        if((widget.isupdateScreen ?? false) == false) {
          Get.to(UpdateProfile(
          ));
        }
      },
        child: Row(
          children: [
            Visibility(
              visible: (widget.isupdateScreen ?? false) == false,
              child: Row(
                children: [
                  CircleAvatar(
                    child: CachedNetworkImage(
                      imageUrl: AuthUtilits.userinfo.data?.photo ?? '',
                    placeholder: (_,__)=> Icon(Icons.image),
                    ),
                    radius: 23,
                  ),
                ],
              ),
            ),

            SizedBox(width: 16,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  '${AuthUtilits.userinfo.data?.firstName ?? ''} ${AuthUtilits.userinfo.data?.lastName ?? ''}',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  '${AuthUtilits.userinfo.data?.email ?? ''}',
                  style: TextStyle(color: Colors.white,fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
