import 'package:flutter/material.dart';
import 'package:real_todo/data/models/Network_response.dart';
import 'package:real_todo/data/models/Task_list_model.dart';
import 'package:real_todo/data/models/summary_count_model.dart';
import 'package:real_todo/data/services/network_caller.dart';
import 'package:real_todo/screen/add_newTask.dart';
import 'package:real_todo/screen/updateTasksheet.dart';
import 'package:real_todo/utils/url-.dart';
import '../Widget/TaskListTile.dart';
import '../Widget/UserprofileBaner.dart';
import '../Widget/summary_card.dart';
import '../Widget/update_task_bottom_sheet.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  bool _getCountsummaryInprogress = false,
      _getNewTaskInProgress = false;
  SummaryCountModel summaryCountModel = SummaryCountModel();

  TaskListModel taskListModel = TaskListModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCountSummary();
      getNewTask();
    });
  }

  Future<void> getCountSummary() async {
    _getCountsummaryInprogress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest(
        Urls.taskStatusCount);
    if (response.issuccess) {
      summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Get new task data failed")));
      }
    }
    _getCountsummaryInprogress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNewTask() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest(
        Urls.newTasks);
    if (response.issuccess) {
      taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Get new task data failed")));
      }
    }
    _getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
  Future<void> getDeleted(String TaskId) async{
    final NetworkResponse response = 
        await NetworkCaller().getRequest(Urls.deleteTask(TaskId));
    if(response.issuccess){
      taskListModel.data!.removeWhere((element) => element.sId == TaskId);
      if(mounted){
        setState(() {
        });
      }
    }else{
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Deletion has been failed")));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const userProfileBanare(),
            _getCountsummaryInprogress ? const Center(
              child: LinearProgressIndicator(),
            ) : SizedBox(
              height: 80,
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: summaryCountModel.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return sumarreay_card(
                    title: summaryCountModel.data![index].sId ?? 'New',
                    number: summaryCountModel.data![index].sum.toString(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 1,
                  );
                },),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: ()async{
                  getNewTask();
                },
                child: _getNewTaskInProgress ? const Center(
                  child: CircularProgressIndicator(),
                ) : ListView.separated(
                  itemCount: taskListModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskListTile(
                      txt: 'New',
                      color: Colors.blue.shade300,
                      data: taskListModel.data![index],
                      onDeleteTap: () {
                        getDeleted(taskListModel.data![index].sId!);
                      },
                      onEditTap: () {
                        // showEditBottomsheet(taskListModel.data![index]);
                        showStatusUpdateBottomSheet(taskListModel.data![index]);
                      },);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNewTask()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  void showEditBottomsheet(TaskData task){


    showModalBottomSheet(
        isScrollControlled: true,
        context: context, builder: (context){
      return  updateTaskbottomSheet(task: task, OnUpdate: () {
        getNewTask();
      },);
    });
  }
void showStatusUpdateBottomSheet(TaskData task) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return UpdateTaskStatusSheet(task: task, onUpdate: () {
        getNewTask();
      });
    },
  );
}
}










