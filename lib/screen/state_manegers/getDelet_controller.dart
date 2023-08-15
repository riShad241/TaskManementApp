import 'package:get/get.dart';

import '../../data/models/Network_response.dart';
import '../../data/services/network_caller.dart';
import '../../utils/url-.dart';
import 'new_task_controller.dart';

class GetDeleteController extends GetxController{
  final NewTaskController _newTaskController = Get.find<NewTaskController>();
  Future<bool> getDeleted(String TaskId) async{
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTask(TaskId));
    if(response.issuccess){
      _newTaskController.tasklistmodel.data!.removeWhere((element) => element.sId == TaskId);
      update();
      return true;
    }else{
      return false;
    }
  }
}