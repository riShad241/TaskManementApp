import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key, required this.txt, required this.color,
  });
  final String txt;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("title will be here"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("title will be here"),
          Text("Data"),
          Row(
            children: [
               Chip(label: Text(txt,style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: color,),
              const Spacer(),
              IconButton(onPressed: (){}, icon: Icon(Icons.delete_forever_outlined,color: Colors.red.shade300,)),
              IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.green.shade300,)),
            ],
          )
        ],
      ),
    );
  }
}