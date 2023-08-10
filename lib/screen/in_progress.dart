import 'package:flutter/material.dart';
import 'package:real_todo/data/models/Network_response.dart';
import 'package:real_todo/data/models/Task_list_model.dart';
import 'package:real_todo/data/services/network_caller.dart';
import 'package:real_todo/utils/url-.dart';

import '../Widget/TaskListTile.dart';
import '../Widget/UserprofileBaner.dart';
class In_progress extends StatefulWidget {
  const In_progress({Key? key}) : super(key: key);

  @override
  State<In_progress> createState() => _In_progressState();
}

class _In_progressState extends State<In_progress> {
  bool _getprogressTaskInprogress = false;
  TaskListModel _taskListModel = TaskListModel();

  Future<void> getInprogressTask() async{
    _getprogressTaskInprogress = true;
    if(mounted){
      setState(() {});
    }
    final NetworkResponse response = 
        await NetworkCaller().getRequest(Urls.progressTasks);
    if(response.issuccess){
      _taskListModel = TaskListModel.fromJson(response.body!);
    }else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("In progress Task get Failed")));
      }
    }
    _getprogressTaskInprogress = false;
    if(mounted){
      setState(() {});
    }
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getInprogressTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const userProfileBanare(),
            Expanded(
              child: _getprogressTaskInprogress ? const Center(child:CircularProgressIndicator() ,) : ListView.separated(
                itemCount: _taskListModel.data?.length ?? 0,
                itemBuilder: (context,index){
                  return  TaskListTile(txt: 'Progress', color: Colors.purple.shade300,
                    data: _taskListModel.data![index],
                    onDeleteTap: () {  },
                    onEditTap: () {  }, );
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
