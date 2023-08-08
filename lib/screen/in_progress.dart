import 'package:flutter/material.dart';

import '../Widget/TaskListTile.dart';
import '../Widget/UserprofileBaner.dart';
class In_progress extends StatelessWidget {
  const In_progress({Key? key}) : super(key: key);

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
                  return  TaskListTile(txt: 'Progress', color: Colors.purple.shade300,);
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
