import 'package:flutter/material.dart';

import '../Widget/TaskListTile.dart';
import '../Widget/UserprofileBaner.dart';
class Complete extends StatelessWidget {
  const Complete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
           const userProfileBanare(),
            Expanded(
              child: ListView.separated(
                itemCount: 20,
                itemBuilder: (context,index){
                  return  TaskListTile(txt: 'Completed', color: Colors.green.shade300,);
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
