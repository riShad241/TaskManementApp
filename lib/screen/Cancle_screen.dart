import 'package:flutter/material.dart';
import 'package:real_todo/data/models/Network_response.dart';
import 'package:real_todo/data/models/Task_list_model.dart';
import 'package:real_todo/data/services/network_caller.dart';
import 'package:real_todo/utils/url-.dart';

import '../Widget/TaskListTile.dart';
import '../Widget/UserprofileBaner.dart';
class Cancle extends StatefulWidget {
  const Cancle({Key? key}) : super(key: key);

  @override
  State<Cancle> createState() => _CancleState();
}

class _CancleState extends State<Cancle> {
  bool _cancelInprogress = false;

  TaskListModel _taskListModel = TaskListModel();

  Future<void> getCancle() async{
    _cancelInprogress = true;
    if(mounted){
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.cancelledTasks);
    if(response.issuccess){
      _taskListModel = TaskListModel.fromJson(response.body!);
    }else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cancel Task get Failed")));
      }
    }
    _cancelInprogress = false;
    if(mounted){
      setState(() {});
    }
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCancle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            userProfileBanare(),
            Expanded(
              child: _cancelInprogress ? const Center(child: CircularProgressIndicator(),) : ListView.separated(
                itemCount: _taskListModel.data?.length ?? 0,
                itemBuilder: (context,index){
                  return  TaskListTile(txt: 'Cancel', color: Colors.red.shade300,
                    data: _taskListModel.data![index],
                    onDeleteTap: () {  },
                    onEditTap: () {  },);
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