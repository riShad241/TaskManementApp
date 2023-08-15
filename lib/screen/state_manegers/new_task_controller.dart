import 'package:get/get.dart';

import '../../data/models/Network_response.dart';
import '../../data/models/Task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../utils/url-.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;

  bool get newtasInprogress => _getNewTaskInProgress;
  TaskListModel taskListModel = TaskListModel();

  TaskListModel get tasklistmodel => taskListModel;

  Future<bool> getNewTask() async {
    _getNewTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTasks);
    _getNewTaskInProgress = false;
    if (response.issuccess) {
      taskListModel = TaskListModel.fromJson(response.body!);
      update();
      return true;
    } else {
      return false;
    }
  }
}