import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_todo/Widget/background_widget.dart';
import 'package:real_todo/data/models/Task_list_model.dart';
import 'package:real_todo/screen/state_manegers/InprogressTask_controller.dart';
import 'package:real_todo/screen/state_manegers/getDelet_controller.dart';
import 'package:real_todo/screen/state_manegers/new_task_controller.dart';
import 'package:real_todo/screen/updateTasksheet.dart';
import '../Widget/TaskListTile.dart';
import '../Widget/UserprofileBaner.dart';
import '../Widget/update_task_bottom_sheet.dart';

class In_progress extends StatefulWidget {
  const In_progress({Key? key}) : super(key: key);

  @override
  State<In_progress> createState() => _In_progressState();
}

class _In_progressState extends State<In_progress> {
  final InprogressController _inprogressController =
      Get.find<InprogressController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _inprogressController.getInprogressTask();
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
              GetBuilder<InprogressController>(builder: (_) {
                if (_inprogressController.inprogress) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount:
                      _inprogressController.tasklistmodel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskListTile(
                      txt: 'Progress',
                      color: Colors.purple.shade300,
                      data: _inprogressController.tasklistmodel.data![index],
                      onDeleteTap: () {
                      },
                      onEditTap: () {
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
