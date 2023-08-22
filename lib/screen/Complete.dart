import 'package:flutter/material.dart';
import 'package:real_todo/Widget/background_widget.dart';
import 'package:real_todo/data/models/Network_response.dart';
import 'package:real_todo/data/models/Task_list_model.dart';
import 'package:real_todo/data/services/network_caller.dart';
import 'package:real_todo/utils/url-.dart';

import '../Widget/TaskListTile.dart';
import '../Widget/UserprofileBaner.dart';
class Complete extends StatefulWidget {
  const Complete({Key? key}) : super(key: key);

  @override
  State<Complete> createState() => _CompleteState();
}

class _CompleteState extends State<Complete> {
  bool _CompleteInprogeress = false;
  TaskListModel _taskListModel = TaskListModel();
  Future<void> getComplete() async{
    _CompleteInprogeress = true;
    if(mounted){
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.completedTask);
    if(response.issuccess){
      _taskListModel = TaskListModel.fromJson(response.body!);
    }else{
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Completed get failed")));
      }
    }
    _CompleteInprogeress = false;
    if(mounted){
      setState(() {
      });
    }
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackgroud(
          child: Column(
            children: [
             const userProfileBanare(),
              Expanded(
                child: _CompleteInprogeress ? const Center(child: CircularProgressIndicator(),) : ListView.separated(
                  itemCount: _taskListModel.data?.length ?? 0,
                  itemBuilder: (context,index){
                   return  TaskListTile(txt: 'Completed', color: Colors.green.shade300,
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
      ),
    );
  }
}
