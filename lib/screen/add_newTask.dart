
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:real_todo/Widget/UserprofileBaner.dart';
import 'package:real_todo/data/models/Network_response.dart';
import 'package:real_todo/data/services/network_caller.dart';
import 'package:real_todo/screen/bottom_nav_base_screen.dart';
import 'package:real_todo/utils/url-.dart';
class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
 final  TextEditingController _subjectTEcontroller = TextEditingController();
 final  TextEditingController _descriptionTEcontroller = TextEditingController();
 bool _adNewTaskInprogress = false;

 Future<void> addnewTask() async{
   _adNewTaskInprogress = true;
   if(mounted){
     setState(() {
     });
   }
   Map<String, dynamic> requestBody = {
     "title" : _subjectTEcontroller.text.trim(),
     "description" : _descriptionTEcontroller.text.trim(),
     "status" : "New"
   };
   final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.createTask, requestBody);
   _adNewTaskInprogress = false;
   if(mounted){
     setState(() {

     });
   }
   if(response.issuccess){
     _subjectTEcontroller.clear();
     _descriptionTEcontroller.clear();
     if(mounted){
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Task added  Successsfull")));
     }
   }else{
     if(mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text("Task add failed")));
     }
   }
 }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const userProfileBanare(),

            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add New Task",style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: _subjectTEcontroller,
                    decoration: const InputDecoration(
                      hintText: 'Subject'
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _descriptionTEcontroller,
                    maxLines: 7,
                    decoration: const InputDecoration(
                      hintText: 'Description'
                    ),
                  ),

                  const SizedBox(height: 8,),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _adNewTaskInprogress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(onPressed: (){
                      addnewTask();
                    }, child: const Icon(Icons.arrow_circle_right_outlined)),
                  ),
                )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
