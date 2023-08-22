import 'package:get/get.dart';

import '../../data/models/Network_response.dart';
import '../../data/models/Task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../utils/url-.dart';

class InprogressController extends GetxController {
  bool _getprogressTaskInprogress = false;
  bool get inprogress => _getprogressTaskInprogress;


  TaskListModel _taskListModel = TaskListModel();

  TaskListModel get tasklistmodel => _taskListModel;
  Future<bool> getInprogressTask() async {
    _getprogressTaskInprogress = true;
    update();
    final NetworkResponse response =
            await NetworkCaller().getRequest(Urls.progressTasks);
    _getprogressTaskInprogress = false;
    if (response.issuccess) {

        _taskListModel = TaskListModel.fromJson(response.body!);
        update();
        return true;
      } else {
        return false;
      }
    }
  }