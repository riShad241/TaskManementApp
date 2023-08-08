import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_todo/data/models/auth_utility.dart';

import 'package:real_todo/screen/Update_profile.dart';
import 'package:real_todo/screen/auth/Login_Screen.dart';


class userProfileBanare extends StatefulWidget {
  const userProfileBanare({
    super.key,
  });

  @override
  State<userProfileBanare> createState() => _userProfileBanareState();
}

class _userProfileBanareState extends State<userProfileBanare> {
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      trailing: Column(
        children: [
          Expanded(
            child: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfile()));
            }, icon:const Icon(Icons.edit)),
          ),
          Expanded(
            child: IconButton(onPressed: () async {
               await AuthUtilits.clearUserInfo();
               if(mounted) {
                 Navigator.pushAndRemoveUntil(context,
                     MaterialPageRoute(builder: (context) => LogIn_screen()), (
                         route) => false);
               }
            }, icon: Icon(Icons.logout_outlined)),
          )
        ],
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 16),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(AuthUtilits.userinfo.data?.photo ?? '',),
        onBackgroundImageError: (_,__){
          const Icon(Icons.image);
        },
        radius: 25,
      ),
      title: Text('${AuthUtilits.userinfo.data?.firstName ?? ''}${AuthUtilits.userinfo.data?.lastName ?? ''}' ,
      style: TextStyle(fontSize: 18,color: Colors.white),),
      subtitle: Text('${AuthUtilits.userinfo.data?.email??''}' ,style: TextStyle(color: Colors.white),),
      tileColor: Colors.green,
    );
  }
}