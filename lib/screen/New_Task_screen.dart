import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_todo/Widget/background_widget.dart';
import 'package:real_todo/data/models/Task_list_model.dart';
import 'package:real_todo/screen/add_newTask.dart';
import 'package:real_todo/screen/state_manegers/getDelet_controller.dart';
import 'package:real_todo/screen/state_manegers/new_task_controller.dart';
import 'package:real_todo/screen/state_manegers/summary_count_controller.dart';
import 'package:real_todo/screen/updateTasksheet.dart';
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



  final SummaryCountController _summaryCountController = Get.find<SummaryCountController>();
   final NewTaskController _newTaskController = Get.find<NewTaskController>();
   final GetDeleteController _getDeleteController = Get.find<GetDeleteController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _summaryCountController.getCountSummary();
      _newTaskController.getNewTask();
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
              GetBuilder<SummaryCountController>(
                builder: (_) {
                  if(_summaryCountController.getCountsummaryInprogress){
                    return const Center(
                      child: LinearProgressIndicator(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _summaryCountController.summarycountmodel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return sumarreay_card(
                            title: _summaryCountController.summarycountmodel.data![index].sId ?? 'New',
                            number: _summaryCountController.summarycountmodel.data![index].sum.toString(),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 1,
                          );
                        },),
                    ),
                  );
                }
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: ()async{
                    _newTaskController.getNewTask();
                    _summaryCountController.getCountSummary();

                  },
                  child:  GetBuilder<NewTaskController>(
                    builder: (_) {
                      if(_newTaskController.newtasInprogress){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.separated(
                        itemCount: _newTaskController.tasklistmodel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskListTile(
                            txt: 'New',
                            color: Colors.blue.shade300,
                            data: _newTaskController.tasklistmodel.data![index],
                            onDeleteTap: () {
                              _getDeleteController.getDeleted(_newTaskController.tasklistmodel.data![index].sId!);
                            },
                            onEditTap: () {
                              // showEditBottomsheet(taskListModel.data![index]);
                              showStatusUpdateBottomSheet(_newTaskController.tasklistmodel.data![index]);
                            },);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },);
                    }
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddNewTask());
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
        _newTaskController.getNewTask();
      },);
    });
  }
void showStatusUpdateBottomSheet(TaskData task) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return UpdateTaskStatusSheet(task: task, onUpdate: () {
        _newTaskController.getNewTask();
      });
    },
  );
}
}










