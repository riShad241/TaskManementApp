import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/models/Task_list_model.dart';

class TaskListTile extends StatelessWidget {
  final VoidCallback onDeleteTap, onEditTap;
  const TaskListTile({
    super.key, required this.txt, required this.color, required this.data, required this.onDeleteTap, required this.onEditTap,
  });

  final TaskData data;
  final String txt;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          title: Text(data.title ?? 'Unknown'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.description ?? ''),
              Text(data.createdDate ?? ''),
              Row(
                children: [
                   Chip(label: Text(data.status ?? '$txt',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: color,),
                  const Spacer(),
                  IconButton(onPressed: onDeleteTap, icon: Icon(Icons.delete_forever_outlined,color: Colors.red.shade300,)),
                  IconButton(onPressed: onEditTap, icon: Icon(Icons.edit,color: Colors.green.shade300,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}