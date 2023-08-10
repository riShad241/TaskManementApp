import 'package:flutter/material.dart';

import '../data/models/Network_response.dart';
import '../data/models/Task_list_model.dart';
import '../data/services/network_caller.dart';
import '../utils/url-.dart';
class updateTaskbottomSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback OnUpdate;

  const updateTaskbottomSheet({super.key, required this.task, required this.OnUpdate});
  @override
  State<updateTaskbottomSheet> createState() => _updateTaskbottomSheetState();
}

class _updateTaskbottomSheetState extends State<updateTaskbottomSheet> {
  late TextEditingController _subjectTEController ;

  late TextEditingController _DescriotionTEController ;

  bool updateTaskeInprogress = false;
  @override
  void initState() {
    _subjectTEController = TextEditingController(text: widget.task.title);
    _DescriotionTEController = TextEditingController(text: widget.task.description);
    super.initState();
  }
  Future<void> updateTask() async {
    updateTaskeInprogress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest(
        Urls.createTask);
    updateTaskeInprogress = false;
    if(mounted){
      setState(() {
      });
    }
    if (response.issuccess) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Get Update task data Success")));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Get update task data failed")));
      }
    }
    updateTaskeInprogress = false;
    if (mounted) {
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Update New Task",style: Theme.of(context).textTheme.titleLarge,),
                  const Spacer(),
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.clear))
                ],
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _subjectTEController,
                decoration: const InputDecoration(
                    hintText: 'Subject'
                ),
              ),
              const SizedBox(height: 8,),
              TextFormField(
                controller: _DescriotionTEController,
                maxLines: 7,
                decoration: const InputDecoration(
                    hintText: 'Description'
                ),
              ),

              const SizedBox(height: 8,),
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: updateTaskeInprogress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(onPressed: (){
                  }, child: const Text('update')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}