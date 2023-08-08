import 'package:flutter/material.dart';

import '../Widget/TaskListTile.dart';
import '../Widget/UserprofileBaner.dart';
class Cancle extends StatelessWidget {
  const Cancle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            userProfileBanare(),
            Expanded(
              child: ListView.separated(
                itemCount: 20,
                itemBuilder: (context,index){
                  return  TaskListTile(txt: 'Cancel', color: Colors.red.shade300,);
                },
                separatorBuilder: (BuildContext context, int index){
                  return const Divider();
                },),
            )
          ],
        ),
      ),
    );
  }
}